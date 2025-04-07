import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';

class budget_textfieldHome extends StatelessWidget {
  const budget_textfieldHome({
    super.key,
    required TextEditingController budgetHomeController,
  }) : _budgetHomeController = budgetHomeController;

  final TextEditingController _budgetHomeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      hintText: 'Budget',
      controller: _budgetHomeController,
      keybordTpe: TextInputType.number,
      color1: white,
      keyboardType: TextInputType.text,
    );
  }
}
