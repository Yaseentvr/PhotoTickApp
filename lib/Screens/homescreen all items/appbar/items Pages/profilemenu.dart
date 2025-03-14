import 'package:flutter/material.dart';
import 'package:phototickapp/db/login_Function/loginFunction.dart';
import 'package:phototickapp/db/login_model/loginModel.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Profilemenu extends StatelessWidget {
  Profilemenu({
    super.key,
    required String name,
    required String phone,
  });

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEFFBFB),
      ),
      backgroundColor: Color(0xFFEFFBFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: FutureBuilder<Loginmodel?>(
              future: getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No user found'));
                } else {
                  final user = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.loginName,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 71, 71, 71)),
                                ),
                                Text(
                                  user.loginPhone,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 71, 71, 71)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'App Info',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF57CFCE)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Photo Ticker is the perfect tool for photographers to manage their work effortlessly.\n You can note down your new projects, client details, event locations, and dates.\n Keep track of payments, tick off completed jobs, and stay on top of pending payments.\n Add your assistants with their contact details and get automatic notifications when an event is approaching.\n Simplify your photography business with this all-in-one management app!',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 71, 71, 71)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF57CFCE)),
                              ),
                            ],
                          ),
                          Text(
                            '1234567890',
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 71, 71, 71)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'yaseen@gmail.com',
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        const Color.fromARGB(255, 71, 71, 71)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
