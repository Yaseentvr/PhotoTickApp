import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class phone_textfield extends StatelessWidget {
  const phone_textfield({
    super.key,
    required TextEditingController phoneHomeController,
  }) : _phoneHomeController = phoneHomeController;

  final TextEditingController _phoneHomeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hintText: 'Phone',
      controller: _phoneHomeController,
      keybordTpe: TextInputType.phone,
      color1: const Color.fromARGB(255, 211, 211, 211),
       keyboardType: TextInputType.text,
    );
  }
}
