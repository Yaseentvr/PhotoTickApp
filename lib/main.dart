import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/Screens/splashScreens/splashscreen.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/company_expense/companyExpense_db.dart';
import 'package:phototickapp/db/company_expense/companyExpense_model.dart';
import 'package:phototickapp/db/image_Screen_db/imageScreen_Db.dart';
import 'package:phototickapp/db/image_Screen_model/imageScreen%20_model.dart';
import 'package:phototickapp/db/login_model/loginModel.dart';
import 'package:phototickapp/db/personal_Equipment_Db/personalEquipmentModel.dart';
import 'package:phototickapp/db/personal_assistant_model/personal_assistant_model.dart';
import 'package:phototickapp/db/personal_budget_model/personal_budget_model.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AssistantModelAdapter());
  Hive.registerAdapter(LoginmodelAdapter());
  Hive.registerAdapter(RoleModelAdapter());
  Hive.registerAdapter(ClientModelAdapter());
  Hive.registerAdapter(PersonalBudgetModelAdapter());
  Hive.registerAdapter(PersonalAssistantModelAdapter());
  Hive.registerAdapter(PersonalequipmentmodelAdapter());
  Hive.registerAdapter(imagescreenModelAdapter());
  Hive.registerAdapter(CompanyexpenseModelAdapter());
  // Hive.registerAdapter(TodoModelAdapter());
 
  await Hive.openBox<imagescreen_Model>(imageName);
  await Hive.openBox<Loginmodel>('loginBox');

  await Hive.openBox<RoleModel>('roleBox');

  await Hive.openBox<PersonalAssistantModel>('assBox');
  await Hive.openBox<CompanyexpenseModel>(expenseBoxName);
  await Hive.openBox<AssistantModel>('assistant_db'); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Screensize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(
        clientCheck: ClientModel(
          id: '',
          date: '',
          time: '',
          name: '',
          location: '',
          event: '',
          phone: '',
          budget: '',
        ),
      ),
    );
  }
}
