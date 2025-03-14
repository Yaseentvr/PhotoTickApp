import 'package:flutter/material.dart';
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
          color1: const Color.fromARGB(255, 211, 211, 211),
           keyboardType: TextInputType.text,
        );
  }
}

