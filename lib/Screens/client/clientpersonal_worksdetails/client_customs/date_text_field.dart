import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';

class date_textField extends StatelessWidget {
  const date_textField({
    super.key,
    required TextEditingController dateHomeController,
  }) : _dateHomeController = dateHomeController;

  final TextEditingController _dateHomeController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.datetime,
      controller: _dateHomeController,
      decoration: InputDecoration(
          fillColor: white,
          filled: true,
          hintText: 'Date',
          suffixIcon: Icon(Icons.date_range_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
          )),
    );
  }
}
