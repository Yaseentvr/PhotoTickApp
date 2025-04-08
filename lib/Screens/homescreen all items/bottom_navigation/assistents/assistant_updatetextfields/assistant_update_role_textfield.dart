import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assistant_updateRole_textfield extends StatelessWidget {
  const assistant_updateRole_textfield({
    super.key,
    required this.updateRoleController,
  });

  final TextEditingController updateRoleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Role',
        labelText: 'Role',
        controller: updateRoleController,
        keybordTpe: TextInputType.text,
        color1: const Color.fromARGB(255, 211, 211, 211),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
