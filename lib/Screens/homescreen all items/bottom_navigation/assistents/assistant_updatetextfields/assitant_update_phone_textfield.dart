import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assitant_updatePhone_textfield extends StatelessWidget {
  const assitant_updatePhone_textfield({
    super.key,
    required this.updatePhoneController,
  });

  final TextEditingController updatePhoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Phone',
        controller: updatePhoneController,
        keybordTpe: TextInputType.phone,
        color1: const Color.fromARGB(255, 211, 211, 211),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
