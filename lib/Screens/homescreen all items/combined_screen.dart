import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/client_list_screen.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/images%20screen/images_screen.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/image_screen_model/image_screen%20_model.dart';

class CombinedScreen extends StatefulWidget {
  @override
  _CombinedScreenState createState() => _CombinedScreenState();
}

class _CombinedScreenState extends State<CombinedScreen> {
  int _selectedIndex = 0;

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
    Imagesscreen(
      images: imagescreen_Model(
        imagePath: '',
        imageId: '',
        place: '',
        date1: '',
        description: '',
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Screen'),
        backgroundColor: const Color(0xFF57CFCE),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Clients',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF57CFCE),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        // ),
      ),
    );
  }
}
