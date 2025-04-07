import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/homescreen.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Secondsplash extends StatefulWidget {
  final String name;
  final String phone;
  final ClientModel clientCheck;

  const Secondsplash({
    super.key,
    required this.name,
    required this.phone,
    required this.clientCheck,
  });

  @override
  State<Secondsplash> createState() => _SecondsplashState();
}

class _SecondsplashState extends State<Secondsplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Homescreen(
          name: widget.name,
          phone: widget.phone,
          place: '',
          clientCheck: widget.clientCheck,
          selectedRoles: '',
        );
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image(
            image: AssetImage(
              'imagesforapp/camera png.png',
            ),
            width: 70,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   'Welcome  ${widget.name}!',
                //   style: TextStyle(
                //       color: const Color.fromARGB(255, 28, 28, 28),
                //       fontSize: 30,
                //       fontWeight: FontWeight.bold),
                // ),
                // Center(
                //     child: Padding(
                //   padding: const EdgeInsets.only(top: 50),
                //   child: Text('Loading...'),
                // ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
