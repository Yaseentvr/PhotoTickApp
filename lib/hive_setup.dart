// hive_setup.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/company_expense/company_expense_db.dart';
import 'package:phototickapp/db/company_expense/company_expense_model.dart';
import 'package:phototickapp/db/image_screen_model/image_screen%20_model.dart';
import 'package:phototickapp/db/login_model/login_%20model.dart';
import 'package:phototickapp/db/personal_assistant_model/personal_assistant_model.dart';
import 'package:phototickapp/db/personal_budget_model/personal_budget_model.dart';
import 'package:phototickapp/db/personal_equipment_Db/personal_equipment_model.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';

Future<void> initializeHive() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(AssistantModelAdapter());
  Hive.registerAdapter(LoginmodelAdapter());
  Hive.registerAdapter(RoleModelAdapter());
  Hive.registerAdapter(ClientModelAdapter());
  Hive.registerAdapter(PersonalBudgetModelAdapter());
  Hive.registerAdapter(PersonalAssistantModelAdapter());
  Hive.registerAdapter(PersonalequipmentmodelAdapter());
  Hive.registerAdapter(imagescreenModelAdapter());
  Hive.registerAdapter(CompanyexpenseModelAdapter());

  // Open Hive boxes
  await Hive.openBox<imagescreen_Model>('imageBox');
  await Hive.openBox<Loginmodel>('loginBox');
  await Hive.openBox<RoleModel>('roleBox');
  await Hive.openBox<PersonalAssistantModel>('assBox');
  await Hive.openBox<CompanyexpenseModel>(expenseBoxName);
  await Hive.openBox<AssistantModel>('assistant_db');
  await Hive.openBox<ClientModel>('clientBox');
}