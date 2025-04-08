import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assitant_updateName_textfield extends StatelessWidget {
  const assitant_updateName_textfield({
    super.key,
    required this.updateNameController,
  });

  final TextEditingController updateNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Name',
        labelText: 'Name',
        controller: updateNameController,
        keybordTpe: TextInputType.name,
        color1: const Color.fromARGB(255, 211, 211, 211),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
