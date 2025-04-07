import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/appbar/items_pages/profilemenu.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/homescreen.dart';

class profileMenu_button extends StatelessWidget {
  const profileMenu_button({
    super.key,
    required this.widget,
  });

  final Homescreen widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Profilemenu(name: widget.name, phone: widget.phone),
            ),
          );
        },
        icon: Icon(Icons.menu));
  }
}
