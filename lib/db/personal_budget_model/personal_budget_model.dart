import 'package:hive_flutter/adapters.dart';

part 'personal_budget_model.g.dart';

@HiveType(typeId: 5)
class PersonalBudgetModel {
  @HiveField(0)
  final String expenseId;
  @HiveField(1)
  final String expenseName;
  @HiveField(2)
  final String expenseAmount;
  @HiveField(3)
  String remainingBudget;
  @HiveField(4)
  final DateTime expenseDate;

  PersonalBudgetModel(
      {required this.expenseAmount,
      required this.expenseId,
      required this.expenseName,
      required this.expenseDate,
      required this.remainingBudget});
}
