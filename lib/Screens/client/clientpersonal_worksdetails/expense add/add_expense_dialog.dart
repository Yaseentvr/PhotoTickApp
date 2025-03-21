import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phototickapp/db/personal_budget_model/personal_budget_model.dart';

class AddExpenseDialog extends StatefulWidget {
  final PersonalBudgetModel? expense;
  final Function(String, double, DateTime) onSubmit;

  const AddExpenseDialog({
    Key? key, 
    this.expense, 
    required this.onSubmit
  }) : super(key: key);

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  late TextEditingController _expenseNameController;
  late TextEditingController _expenseAmountController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _expenseNameController = TextEditingController(text: widget.expense?.expenseName);
    _expenseAmountController = TextEditingController(text: widget.expense?.expenseAmount);
    _selectedDate = widget.expense?.expenseDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.expense == null ? 'Add Expense' : 'Edit Expense'),
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
              decoration: const InputDecoration(labelText: 'Expense Amount'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Date: ${DateFormat('dd-MMMM-yyyy').format(_selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2115),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked; // Update selected date
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String expenseName = _expenseNameController.text.trim();
            String expenseAmountString = _expenseAmountController.text.trim();
            double? expenseAmount = double.tryParse(expenseAmountString);

            if (expenseName.isNotEmpty && expenseAmount != null) {
              widget.onSubmit(expenseName, expenseAmount, _selectedDate);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter valid details')),
              );
            }
          },
          child: Text(widget.expense == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _expenseNameController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }
  
}