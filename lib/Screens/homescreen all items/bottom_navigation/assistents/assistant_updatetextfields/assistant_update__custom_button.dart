import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customButton/customButton.dart';

class assistant_update_CustomButton extends StatelessWidget {
  const assistant_update_CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Custombutton(
      textColor: Colors.black,
      backgroundColor: Color(0xFF57CFCE),
      text: 'Update',
    );
  }
}
