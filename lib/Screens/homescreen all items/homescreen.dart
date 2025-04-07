import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/client_list_screen.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/appbar/items_buttons/company_expenses_button.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/appbar/items_buttons/profile_menu_button.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_add_screen.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/events/event_screen.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/images%20screen/images_screen.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/image_screen_model/image_screen%20_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Homescreen extends StatefulWidget {
  final String name;
  final String phone;
  final String place;
  final String selectedRoles;
  ClientModel clientCheck;

  Homescreen({
    super.key,
    required this.name,
    required this.phone,
    required this.place,
    required this.selectedRoles,
    required this.clientCheck,
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  // Ensure this list remains unchanged
  final List<Widget> _screens = [
    Clientlistscreen(
      clientDetailsClick: ClientModel(
          id: '',
          date: '',
          time: '',
          name: '',
          location: '',
          event: '',
          phone: '',
          budget: '',
          driveLink1: ''),
    ),
    Eventscreen(),
    Imagesscreen(
      images: imagescreen_Model(
        imagePath: '',
        imageId: '',
        place: '',
        date1: '',
        description: '',
      ), // Image screen
    ),
    AssistantsAddScreen(), // Assistants Add Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Screensize();

    // Handle app bar conditionally based on selected index
    PreferredSizeWidget? appBar;
    if (_selectedIndex == 0) {
      appBar = AppBar(
        backgroundColor: appBarColor, // Change app bar color
        elevation: 4,
        leading: company_expenses_button(),
        centerTitle: true,
        title: Text(
          'Photo Tick',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        actions: [
          // notification_Page_button(),
          profileMenu_button(widget: widget),
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: _screens[
            _selectedIndex], // Use the appropriate screen based on selected index
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: boxShadow,
              blurRadius: 15,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_outlined),
                activeIcon: Icon(Icons.event),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_outlined),
                activeIcon: Icon(Icons.image),
                label: 'Images',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Assistants',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: appBarColor,
            unselectedItemColor: grey,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: white,
          ),
        ),
      ),
    );
  }
}
