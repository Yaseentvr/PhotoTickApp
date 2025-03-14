import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customButton/customButton.dart';

class assistant_custom_add_button extends StatelessWidget {
  const assistant_custom_add_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Custombutton(
      textColor: Colors.black,
      backgroundColor: Color(0xFF57CFCE),
      text: 'Save',
      
      
    );
  }
}
