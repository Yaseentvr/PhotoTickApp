
import 'package:hive_flutter/adapters.dart';
 part 'company_expense_model.g.dart';
@HiveType(typeId: 12)
class CompanyexpenseModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
final  String name;
@HiveField(2)
 final double amount;

  CompanyexpenseModel( {required this.name, required this.amount,required this.id,});

}