import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class name_textfield extends StatelessWidget {
  const name_textfield({
    super.key,
    required TextEditingController nameHomeController,
  }) : _nameHomeController = nameHomeController;

  final TextEditingController _nameHomeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hintText: 'Name',
      controller: _nameHomeController,
      keybordTpe: TextInputType.name,
      color1: const Color.fromARGB(255, 211, 211, 211),
       keyboardType: TextInputType.text,
    );
  }
}
