import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String text;
  

  Custombutton({
    super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150,
        height: 40,
        child: Center(
          child: Text(text,style: TextStyle( color: textColor,fontSize: 18),),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
