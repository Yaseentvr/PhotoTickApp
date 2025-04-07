// main.dart
import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/homescreen.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

import 'hive_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and Notifications
  await initializeHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Screensize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(
        name: '', 
        phone: '', 
        place: '', 
        selectedRoles: '', 
        clientCheck: ClientModel(
          id: '', 
          name: '', 
          phone: '', 
          date: '', 
          time: '', 
          location: '', 
          event: '', 
          budget: '', 
          driveLink1: ''
        ) // Provide a default ClientModel instance
      )
    );
  }
}
