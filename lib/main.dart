// main.dart
import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/splash_screens/splashscreen.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

import 'hive_setup.dart';
import 'notification_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and Notifications
  await initializeHive();
  await initializeNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Screensize(); // Ensure this function is properly defined
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
          driveLink1: '',
        ),
      ),
    );
  }
}
