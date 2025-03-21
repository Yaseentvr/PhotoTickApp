import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/appbar/items_pages/companyexpense.dart';

class company_expenses_button extends StatelessWidget {
  const company_expenses_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CompanyExpense()));
        },
        icon: Icon(Icons.payments_rounded));
  }
}
