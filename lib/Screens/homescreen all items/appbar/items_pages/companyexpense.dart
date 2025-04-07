import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phototickapp/db/company_expense/company_expense_db.dart';
import 'package:phototickapp/db/company_expense/company_expense_model.dart';

class CompanyExpense extends StatefulWidget {
  const CompanyExpense({super.key});

  @override
  State<CompanyExpense> createState() => _CompanyExpenseState();
}

class _CompanyExpenseState extends State<CompanyExpense> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    openExpenseBox(); // Open the Hive box for company expenses
  }

  // Add an expense
  void _addExpense(String name, double amount) {
    final newExpense = CompanyexpenseModel(
      id: DateTime.now().toString(),
      name: name,
      amount: amount,
    );
    addExpense(newExpense);
    _nameController.clear();
    _amountController.clear();
    setState(() {});
  }

  // Delete an expense with confirmation dialog
  void _deleteExpense(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteExpense(index); // Delete the expense
                Navigator.of(context).pop(); // Close the dialog
                setState(() {}); // Refresh the UI
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Calculate total expenses
  double _calculateTotal() {
    return calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF57CFCE),
        centerTitle: true,
        title: const Text(
          'Company Expenses',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Expense Input Section
            Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Expense',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF57CFCE),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Expense Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorText: _errorMessage,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Expense Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isNotEmpty &&
                            _amountController.text.isNotEmpty &&
                            double.tryParse(_amountController.text) != null) {
                          _addExpense(
                            _nameController.text,
                            double.parse(_amountController.text),
                          );
                          setState(() {
                            _errorMessage = null; // Reset error message
                          });
                        } else {
                          setState(() {
                            _errorMessage =
                                'Please enter valid expense values.';
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF57CFCE),
                      ),
                      child: const Text('Add Expense'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Total Expenses: Rs ${_calculateTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF57CFCE),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Expense List Section
            ValueListenableBuilder(
              valueListenable:
                  Hive.box<CompanyexpenseModel>(expenseBoxName).listenable(),
              builder: (context, Box<CompanyexpenseModel> box, _) {
                if (box.isEmpty) {
                  return const Center(
                    child: Text(
                      'No expenses added',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true, //Added shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Added physics: const NeverScrollableScrollPhysics(),
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      var expense = box.getAt(index);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          elevation: 1,
                          child: ListTile(
                            title: Text(expense?.name ?? 'Unnamed'),
                            subtitle: Text(
                                'Amount: ${expense?.amount.toStringAsFixed(2) ?? '0.00'}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteExpense(index),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
