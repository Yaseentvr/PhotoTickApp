import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Profilemenu extends StatelessWidget {
  const Profilemenu({super.key});

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Card(
                  color: white,
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
                              color: appBarColor,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Phototick is a comprehensive and user-friendly mobile app designed specifically for photographers and videographers to manage their workflow efficiently. The app allows users to effortlessly add details of their new projects, including client names, event locations, dates, and payment information, making it easier to keep track of ongoing and completed works. It also helps photographers and videographers manage their team by adding assistants’ names, contact details, and their assigned tasks.\n One of the standout features of Phototick is the ability to track expenses, where users can monitor their overall budget, track equipment purchases, rentals, and other project costs. The app also lets users store and access their favorite images, along with links to photo drives, creating a seamless workflow for managing content. Furthermore, users can document all company expenses, ensuring detailed financial tracking. With its organized interface, Phototick streamlines the management of both creative projects and business logistics, providing an all-in-one solution for professionals in the photography and videography field.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 71, 71, 71),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Modification of Terms",
                          style: TextStyle(
                            fontSize: 15,
                            color: appBarColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "We reserve the right to modify or update these Terms at any time. Changes will be effective immediately upon posting to the app, and continued use of Phototick after any changes implies your acceptance of the updated Terms.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 71, 71, 71),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Contact Us If you have any questions or concerns regarding these Terms,\n please contact us at \n[mohammedyaseen19@gmail.com].',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
