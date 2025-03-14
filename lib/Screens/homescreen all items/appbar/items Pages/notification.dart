import 'package:flutter/material.dart';

class notificationPage extends StatelessWidget {
  const notificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('notifications'),
        centerTitle: true,
      ),
    );
  }
}