import 'package:flutter/material.dart';

class timeTextField extends StatelessWidget {
  const timeTextField({
    super.key,
    required TextEditingController timeHomeController,
  }) : _timeHomeController = timeHomeController;

  final TextEditingController _timeHomeController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.datetime,
      controller: _timeHomeController,
      decoration: InputDecoration(
          fillColor:
              const Color.fromARGB(255, 211, 211, 211),
          filled: true,
          hintText: 'Time',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          )),
    );
  }
}
