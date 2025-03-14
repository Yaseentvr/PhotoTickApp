import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/clientListScreen.dart';
import 'package:phototickapp/Screens/homescreen all items/appbar/itemsButtons/company_expenses_button.dart';
import 'package:phototickapp/Screens/homescreen all items/appbar/itemsButtons/notification__page_button.dart';
import 'package:phototickapp/Screens/homescreen all items/appbar/itemsButtons/profile_menu_button.dart';
import 'package:phototickapp/Screens/homescreen all items/bottomNavigation/assistents/assistantAddScreen.dart';
import 'package:phototickapp/Screens/homescreen all items/bottomNavigation/events/eventScreen.dart';
import 'package:phototickapp/Screens/homescreen all items/bottomNavigation/images screen/imagesScreen.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/image_Screen_model/imageScreen%20_model.dart';
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
      ),
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
        backgroundColor: Color(0xFF57CFCE), // Change app bar color
        elevation: 4,
        leading: company_expenses_button(),
        centerTitle: true,
        title: const Text(
          'Photo Tick',
          style: TextStyle(
            fontSize: 24, // Slightly increase font size
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          notification_Page_button(),
          profileMenu_button(widget: widget),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEFFBFB),
      appBar: appBar,
      body: SafeArea(
        child: _screens[_selectedIndex], // Use the appropriate screen based on selected index
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
            selectedItemColor: Color(0xFF57CFCE),
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}