import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/loginScreen/loginscreen.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Splashscreen extends StatefulWidget {
  final ClientModel clientCheck;

  const Splashscreen({super.key, required this.clientCheck});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds before navigating to login screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Loginscreen(
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
        );
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    Screensize();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage('imagesforapp/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                splashTitle(), // Title
                SizedBox(height: 5), // Spacing
                splashsub(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget splashTitle() {
    return Text(
      'Photo Tick',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: white,
      ),
    );
  }

  Widget splashsub() {
    return Text(
      'Note your works',
      style: TextStyle(
        fontSize: 15,
        color: white,
      ),
    );
  }
}
