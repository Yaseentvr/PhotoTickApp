import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keybordTpe;
  final Color color1;
  final Function(String)? validator;
  final IconButton? IconButton1;
  final String labelText;

  CustomTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.keybordTpe,
      required this.color1,
      required this.labelText,
      this.validator,
      this.IconButton1,
      required TextInputType keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keybordTpe,
      controller: controller,
      decoration: InputDecoration(
          suffix: IconButton1,
          hintText: hintText,
          label: Text(hintText),
          fillColor: color1,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
          )),
    );
  }
}
