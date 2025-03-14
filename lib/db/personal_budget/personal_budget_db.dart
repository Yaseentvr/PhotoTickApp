import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/personal_budget_model/personal_budget_model.dart';

ValueNotifier<List<PersonalBudgetModel>> ExpenseListNotifier =
    ValueNotifier([]);
String BoxName = 'expense';

Future<void> addExpense(PersonalBudgetModel expense, double newRemainingBudget) async {
  final ExpenseBox = await Hive.openBox<PersonalBudgetModel>(BoxName);

  // Add expense
  await ExpenseBox.put(expense.expenseId, expense);

  // Update remaining budget
  final budgetBox = await Hive.openBox<double>('budgetBox');
  await budgetBox.put('remainingBudget', newRemainingBudget);

  getAllExpense();
}

Future getAllExpense() async {
  ExpenseListNotifier.value.clear();
  final ExpenseBox = await Hive.openBox<PersonalBudgetModel>(BoxName);
  ExpenseListNotifier.value.addAll(ExpenseBox.values);

  ExpenseListNotifier.notifyListeners();
}

Future<void> deleteExpense(String expenseId, double expenseAmount, double updatedRemainingBudget) async {
  final ExpenseBox = await Hive.openBox<PersonalBudgetModel>(BoxName);

  // Delete expense
  await ExpenseBox.delete(expenseId);

  final budgetBox = await Hive.openBox<double>('budgetBox');
 

  await budgetBox.put('remainingBudget', updatedRemainingBudget);

  // Update remaining budget
  await budgetBox.put('remainingBudget', updatedRemainingBudget);

  getAllExpense();
}

