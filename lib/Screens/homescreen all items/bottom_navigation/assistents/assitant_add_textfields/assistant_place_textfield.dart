import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class assistant_place_textfield extends StatelessWidget {
  const assistant_place_textfield({
    super.key,
    required TextEditingController placeController,
  }) : _placeController = placeController;

  final TextEditingController _placeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextfield(
        hintText: 'Place',
        labelText: 'Place',
        controller: _placeController,
        keybordTpe: TextInputType.text,
        color1: const Color.fromARGB(255, 211, 211, 211),
         keyboardType: TextInputType.text,
      ),
    );
  }
}
