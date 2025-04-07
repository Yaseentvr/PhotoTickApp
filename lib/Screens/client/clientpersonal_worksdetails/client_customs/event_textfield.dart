import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class eventTextfield extends StatelessWidget {
  const eventTextfield({
    super.key,
    required TextEditingController eventHomeController,
  }) : _eventHomeController = eventHomeController;

  final TextEditingController _eventHomeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hintText: 'Event',
      controller: _eventHomeController,
      keybordTpe: TextInputType.text,
      color1: white,
      keyboardType: TextInputType.text,
    );
  }
}
