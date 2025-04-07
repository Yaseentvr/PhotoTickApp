import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/expense%20add/add_expense_dialog.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/personal_budget_model/personal_budget_model.dart';
import 'package:phototickapp/personal_bg_piechart/pie_chart.dart';

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
  bool _showExceedingBudgetMessage = false;

  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();

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

    ExpenseListNotifier.value = expenseBox.values.toList();
    expenseBox.listenable().addListener(() {
      ExpenseListNotifier.value = expenseBox.values.toList();
    });
  }

  Future<void> getRemainingBudget() async {
    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');

    setState(() {
      remainingBudget = budgetBox.get('remainingBudget', defaultValue: budget);
    });
  }

  double _calculateTotalExpenses(List<PersonalBudgetModel> expenses) {
    double total = 0;
    for (var expense in expenses) {
      total += double.tryParse(expense.expenseAmount) ?? 0.0;
    }
    return total;
  }

  void _showAddExpenseDialog({PersonalBudgetModel? expense}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExpenseDialog(
          expense: expense,
          onSubmit: (String expenseName, double expenseAmount,
              DateTime expenseDate) async {
            if (expense != null) {
              await onEditExpenseButtonClicked(
                  expense.expenseId, expenseName, expenseAmount, expenseDate);
            } else {
              await onAddExpenseButtonClicked(
                  expenseName, expenseAmount, expenseDate);
            }
          },
        );
      },
    );
  }

  Future<void> onAddExpenseButtonClicked(
      String expenseName, double expenseAmount, DateTime expenseDate) async {
    double updatedRemainingBudget = (remainingBudget ?? 0) - expenseAmount;

    // Check if the expense exceeds the budget
    if (updatedRemainingBudget < 0) {
      setState(() {
        _showExceedingBudgetMessage = true; // Show the exceed warning
      });
    } else {
      setState(() {
        _showExceedingBudgetMessage = false; // Clear any warning
      });
    }

    final newExpense = PersonalBudgetModel(
      expenseName: expenseName,
      expenseAmount: expenseAmount.toString(),
      expenseId: DateTime.now().toString(),
      expenseDate: expenseDate,
      remainingBudget: updatedRemainingBudget.toString(),
    );

    await addExpense(newExpense, updatedRemainingBudget);

    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');
    await budgetBox.put('remainingBudget', updatedRemainingBudget);

    setState(() {
      remainingBudget = updatedRemainingBudget; // Update remaining budget
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

    await addExpense(updatedExpense, remainingBudget!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF57CFCE),
        title: const Text(
          'TOTAL',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
          ValueListenableBuilder<List<PersonalBudgetModel>>(
            valueListenable: ExpenseListNotifier,
            builder: (context, expenseList, _) {
              double totalExpenses = _calculateTotalExpenses(expenseList);
              return SizedBox(
                width: double.infinity,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChartExpense(
                    expense: totalExpenses,
                    budget: budget ?? 0,
                  ),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Expenses:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<PersonalBudgetModel>>(
              valueListenable: ExpenseListNotifier,
              builder: (context, expenseList, _) {
                if (expenseList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No expenses added yet.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
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
                                  'Date: ${DateFormat('dd-MMMM-yyyy').format(expense.expenseDate)}'), // Formatting date
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Color(0xFF57CFCE)),
                                onPressed: () {
                                  _showAddExpenseDialog(expense: expense);
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  _showAlertDeletePersonalBudget(
                                      context,
                                      expense.expenseId,
                                      double.tryParse(expense.expenseAmount) ??
                                          0.0);
                                },
                                child:
                                    const Icon(Icons.delete, color: Colors.red),
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
    );
  }

  Future<void> _showAlertDeletePersonalBudget(
      BuildContext context, String expenseId, double expenseAmount) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense',
              style: TextStyle(color: Color(0xFF57CFCE))),
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
                    const SnackBar(content: Text('Expense Deleted')));
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteExpense(String expenseId, double expenseAmount) async {
    final expenseBox = await Hive.openBox<PersonalBudgetModel>(
        'expenseBox_${widget.clientId.id}');
    await expenseBox.delete(expenseId);

    double updatedRemainingBudget = remainingBudget! + expenseAmount;
    final budgetBox =
        await Hive.openBox<double>('budgetBox_${widget.clientId.id}');
    await budgetBox.put('remainingBudget', updatedRemainingBudget);

    setState(() {
      this.remainingBudget = updatedRemainingBudget;

      if (remainingBudget! >= 0) {
        _showExceedingBudgetMessage = false;
      }
    });
  }

  @override
  void dispose() {
    _expenseNameController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }
}
