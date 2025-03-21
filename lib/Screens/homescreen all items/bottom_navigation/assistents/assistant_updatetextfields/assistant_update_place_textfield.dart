import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assistant_updatePlace_textfield extends StatelessWidget {
  const assistant_updatePlace_textfield({
    super.key,
    required this.updatePlaceController,
  });

  final TextEditingController updatePlaceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Place',
        controller: updatePlaceController,
        keybordTpe: TextInputType.text,
        color1: const Color.fromARGB(255, 211, 211, 211),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
