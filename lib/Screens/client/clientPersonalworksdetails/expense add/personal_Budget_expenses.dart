import 'package:fl_chart/fl_chart.dart'; // Importing the fl_chart package
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/personal_budget_model/personal_budget_model.dart';

class PersonalBudgetExpenses extends StatefulWidget {
  final ClientModel clientId;
  final String clientBudget1;

  const PersonalBudgetExpenses(
      {Key? key, required this.clientBudget1, required this.clientId})
      : super(key: key);

  @override
  State<PersonalBudgetExpenses> createState() => _PersonalBudgetExpensesState();
}

class _PersonalBudgetExpensesState extends State<PersonalBudgetExpenses> {
  ValueNotifier<List<PersonalBudgetModel>> ExpenseListNotifier =
      ValueNotifier([]);

  double? budget;
  double? remainingBudget;
  DateTime? _selectedDate;
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();
  bool _showExceedingBudgetMessage = false;

  @override
  void initState() {
    super.initState();
    budget = double.tryParse(widget.clientBudget1);
    getRemainingBudget();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final expenseBox = await Hive.openBox<PersonalBudgetModel>(
        'expenseBox_${widget.clientId.id}');
    ExpenseListNotifier.value =
        expenseBox.values.toList().cast<PersonalBudgetModel>();
    expenseBox.listenable().addListener(() {
      ExpenseListNotifier.value =
          expenseBox.values.toList().cast<PersonalBudgetModel>();
    });
  }

  Future<void> getRemainingBudget() async {
    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');
    setState(() {
      remainingBudget = budgetBox.get('remainingBudget', defaultValue: budget);
    });
  }

  void _showAddExpenseDialog({PersonalBudgetModel? expense}) {
    _selectedDate = expense?.expenseDate ?? DateTime.now();

    if (expense != null) {
      _expenseNameController.text = expense.expenseName;
      _expenseAmountController.text = expense.expenseAmount;
      _selectedDate = expense.expenseDate;
    } else {
      _expenseNameController.clear();
      _expenseAmountController.clear();
      _selectedDate = DateTime.now();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _expenseNameController,
                  decoration: const InputDecoration(labelText: 'Expense Name'),
                ),
                TextField(
                  controller: _expenseAmountController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Expense Amount'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                        'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                    IconButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2115),
                        );
                        if (picked != null && picked != _selectedDate) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String expenseName = _expenseNameController.text.trim();
                String expenseAmountString =
                    _expenseAmountController.text.trim();
                double? expenseAmount = double.tryParse(expenseAmountString);

                if (expenseName.isNotEmpty &&
                    expenseAmount != null &&
                    _selectedDate != null) {
                  if (expense != null) {
                    await onEditExpenseButtonClicked(expense.expenseId,
                        expenseName, expenseAmount, _selectedDate!);
                  } else {
                    await onAddExpenseButtonClicked(
                        expenseName, expenseAmount, _selectedDate!);
                  }
                  _expenseNameController.clear();
                  _expenseAmountController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid details')),
                  );
                }
              },
              child: Text(expense == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlertDeletePersonalBudget(
      BuildContext context, String expenseId, double expenseAmount) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await deleteExpense(expenseId, expenseAmount);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense Deleted')),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> onAddExpenseButtonClicked(
      String expenseName, double expenseAmount, DateTime expenseDate) async {
    // Check if the expense exceeds the remaining budget
    if (expenseAmount > (remainingBudget ?? 0)) {
      setState(() {
        _showExceedingBudgetMessage = true; // Trigger the warning message
      });
      return; // Exit if the expense exceeds the budget
    }

    final newExpense = PersonalBudgetModel(
      expenseName: expenseName,
      expenseAmount: expenseAmount.toString(),
      expenseId: DateTime.now().toString(),
      expenseDate: expenseDate,
      remainingBudget: ((remainingBudget ?? 0) - expenseAmount).toString(),
    );

    double updatedRemainingBudget = (remainingBudget ?? 0) - expenseAmount;
    await addExpense(newExpense, updatedRemainingBudget);

    // Update the budget box and remaining budget
    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');
    await budgetBox.put('remainingBudget', updatedRemainingBudget);

    setState(() {
      remainingBudget = updatedRemainingBudget;
      _showExceedingBudgetMessage = false; // Reset message state
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense added successfully')),
    );
  }

  Future<void> onEditExpenseButtonClicked(String expenseId, String expenseName,
      double expenseAmount, DateTime expenseDate) async {
    final updatedExpense = PersonalBudgetModel(
      expenseName: expenseName,
      expenseAmount: expenseAmount.toString(),
      expenseId: expenseId,
      expenseDate: expenseDate,
      remainingBudget: remainingBudget!.toString(),
    );

    await addExpense(updatedExpense, remainingBudget!); // Assuming this updates rather than adds
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense updated successfully')));
  }

  Future<void> addExpense(
      PersonalBudgetModel expense, double updatedRemainingBudget) async {
    final expenseBox = await Hive.openBox<PersonalBudgetModel>(
        'expenseBox_${widget.clientId.id}');
    await expenseBox.put(expense.expenseId, expense);

    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');
    await budgetBox.put('remainingBudget', updatedRemainingBudget);
  }

  Future<void> deleteExpense(String expenseId, double expenseAmount) async {
    final expenseBox = await Hive.openBox<PersonalBudgetModel>(
        'expenseBox_${widget.clientId.id}');
    await expenseBox.delete(expenseId);

    double updatedRemainingBudget = (remainingBudget ?? 0) + expenseAmount;
    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');
    await budgetBox.put('remainingBudget', updatedRemainingBudget);

    setState(() {
      this.remainingBudget = updatedRemainingBudget;
    });
  }

  // Function to prepare pie chart data
  List<PieChartSectionData> getPieChartData(List<PersonalBudgetModel> expenseList) {
    double totalExpenses = expenseList.fold(0, (sum, item) => sum + double.parse(item.expenseAmount));
    double totalBudget = budget ?? 0;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: totalBudget,
        title: 'Budget: ${totalBudget.toStringAsFixed(2)}',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalExpenses,
        title: 'Expenses: ${totalExpenses.toStringAsFixed(2)}',
        radius: 50,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFFBFB),
        title: const Text(
          'TOTAL',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF57CFCE),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 0,
              shadowColor: Colors.white,
              color: Colors.white,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Budget: ${widget.clientBudget1}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Remaining Budget: ${remainingBudget?.toStringAsFixed(2) ?? widget.clientBudget1}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    if (_showExceedingBudgetMessage)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Expense exceeds remaining budget!',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Expenses:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          // Pie chart section
          ValueListenableBuilder(
            valueListenable: ExpenseListNotifier,
            builder: (context, List<PersonalBudgetModel> expenseList, _) {
              if (expenseList.isEmpty) {
                return const Center(
                  child: Text(
                    'No expenses added yet.',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
              return Container(
                height: 250,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PieChart(
                  PieChartData(
                    sections: getPieChartData(expenseList),
                    centerSpaceRadius: 40,
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: ExpenseListNotifier,
              builder: (context, List<PersonalBudgetModel> expenseList, _) {
                return ListView.builder(
                  itemCount: expenseList.length,
                  itemBuilder: (context, index) {
                    final expense = expenseList[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(expense.expenseName),
                              Text(
                                  'Rs: ${double.tryParse(expense.expenseAmount)?.toStringAsFixed(1) ?? '0.00'}'),
                              Text(
                                  'Date: ${expense.expenseDate.toLocal().toString().split(' ')[0]}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showAddExpenseDialog(expense: expense);
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  _showAlertDeletePersonalBudget(
                                    context,
                                    expense.expenseId,
                                    double.tryParse(expense.expenseAmount) ?? 0.0,
                                  );
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseDialog();
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF57CFCE),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _expenseNameController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }
}