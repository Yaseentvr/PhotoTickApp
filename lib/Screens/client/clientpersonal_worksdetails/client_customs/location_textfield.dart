import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class location_textfield extends StatelessWidget {
  const location_textfield({
    super.key,
    required TextEditingController locationHomeController,
  }) : _locationHomeController = locationHomeController;

  final TextEditingController _locationHomeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hintText: 'Location',
      labelText: 'Location',
      controller: _locationHomeController,
      keybordTpe: TextInputType.streetAddress,
      color1: white,
      keyboardType: TextInputType.text,
    );
  }
}
