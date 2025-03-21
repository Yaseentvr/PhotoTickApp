import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/appbar/items_pages/notification.dart';

class notification_Page_button extends StatelessWidget {
  const notification_Page_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => notificationPage()));
        },
        icon: Icon(Icons.notifications));
  }
}
