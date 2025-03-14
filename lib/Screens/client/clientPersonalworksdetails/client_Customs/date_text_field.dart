import 'package:flutter/material.dart';

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
          fillColor:
              const Color.fromARGB(255, 211, 211, 211),
          filled: true,
          hintText: 'Date',
          suffixIcon: Icon(Icons.date_range_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          )),
    );
  }
}
