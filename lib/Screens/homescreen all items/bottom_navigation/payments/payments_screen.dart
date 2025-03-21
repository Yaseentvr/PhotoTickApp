import 'package:flutter/material.dart';

class Paymentsscreen extends StatefulWidget {
  const Paymentsscreen({super.key});

  @override
  State<Paymentsscreen> createState() => _PaymentsscreenState();
}

class _PaymentsscreenState extends State<Paymentsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xFFF2F4F3),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFF2F4F3),
        title: Text('Payments'),
      ),
    );
  }
}