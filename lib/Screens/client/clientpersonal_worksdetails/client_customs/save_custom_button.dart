import 'package:flutter/material.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/custom/customButton/customButton.dart';

class save_customButton extends StatelessWidget {
  const save_customButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        textColor: Colors.white,
        backgroundColor: appBarColor,
        text: 'Save',
        
      );
  }
}
