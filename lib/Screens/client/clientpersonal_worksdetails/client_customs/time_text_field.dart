import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';

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
             white,
          filled: true,
          hintText: 'Time',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
           
          )),
    );
  }
}
