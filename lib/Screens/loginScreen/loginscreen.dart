import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/loginScreen/login_register_name_and_phone.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Loginscreen extends StatefulWidget {
  final ClientModel clientCheck;
  const Loginscreen({super.key, required this.clientCheck});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _loginNameController = TextEditingController();
  final _loginPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Screensize();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('imagesforapp/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Photo Tick',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 35),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Note your works',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'You can note down your new projects, client details, event locations, and dates.',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15),
                  ),
                ),
              ),
              const Spacer(),
              loginRegisterNameAndPhone(
                  loginNameController: _loginNameController,
                  loginPhoneController: _loginPhoneController,
                  clientCheck: ClientModel(id: '', date: '', time: '', name: '', location: '', event: '', phone: '', budget: '',),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginButtonClicked() async {
    final name = _loginNameController.text.trim();
    final phone = _loginPhoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      return;
    }
  }
}
