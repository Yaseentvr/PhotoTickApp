import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assistant_phone_textfield extends StatelessWidget {
  const assistant_phone_textfield({
    super.key,
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Phone',
        controller: _phoneController,
        keybordTpe: TextInputType.phone,
        color1: const Color.fromARGB(255, 211, 211, 211),
         keyboardType: TextInputType.text,
      ),
    );
  }
}
