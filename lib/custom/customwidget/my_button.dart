import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text1;
  VoidCallback onPressed;
 MyButton({super.key, required this.text1, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
    child: Text(text1),
    );
  }
}
