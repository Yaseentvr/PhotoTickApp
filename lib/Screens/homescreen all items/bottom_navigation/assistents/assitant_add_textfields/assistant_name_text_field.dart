import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assistant_name_textField extends StatelessWidget {
  const assistant_name_textField({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Name',
        labelText: 'Name',
        controller: _nameController,
        keybordTpe: TextInputType.name,
        color1: const Color.fromARGB(255, 211, 211, 211),
         keyboardType: TextInputType.text,
      ),
    );
  }
}
