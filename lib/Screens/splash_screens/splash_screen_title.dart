import 'package:flutter/material.dart';

class splash_screen_title extends StatelessWidget {
  const splash_screen_title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Photo Tick',
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
