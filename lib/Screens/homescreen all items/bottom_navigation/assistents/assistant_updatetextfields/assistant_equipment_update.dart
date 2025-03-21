import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assistant_updateEquipment_textfield extends StatelessWidget {
  const assistant_updateEquipment_textfield({
    super.key,
    required this.updateEquipmentController,
  });

  final TextEditingController updateEquipmentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Place',
        controller: updateEquipmentController,
        keybordTpe: TextInputType.text,
        color1: const Color.fromARGB(255, 211, 211, 211),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
