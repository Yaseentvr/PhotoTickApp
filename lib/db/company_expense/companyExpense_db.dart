import 'package:hive_flutter/hive_flutter.dart';
import 'companyExpense_model.dart';

const String expenseBoxName = 'companyExpenses';

// Open Hive Box
Future<void> openExpenseBox() async {
  await Hive.openBox<CompanyexpenseModel>(expenseBoxName);
}

// Add a new expense
Future<void> addExpense(CompanyexpenseModel expense) async {
  final expenseBox = Hive.box<CompanyexpenseModel>(expenseBoxName);
  await expenseBox.add(expense);
}

// Delete an expense by index
Future<void> deleteExpense(int index) async {
  final expenseBox = Hive.box<CompanyexpenseModel>(expenseBoxName);
  await expenseBox.deleteAt(index);
}

// Get total expenses
double calculateTotal() {
  final expenseBox = Hive.box<CompanyexpenseModel>(expenseBoxName);
  double total = 0;
  for (var i = 0; i < expenseBox.length; i++) {
    total += expenseBox.getAt(i)?.amount ?? 0;
  }
  return total;
}
