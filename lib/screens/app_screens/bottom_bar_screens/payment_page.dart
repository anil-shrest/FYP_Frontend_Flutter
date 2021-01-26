import 'package:flutter/material.dart';

class PaymentPageScreen extends StatefulWidget {
  @override
  _PaymentPageScreenState createState() => _PaymentPageScreenState();
}

class _PaymentPageScreenState extends State<PaymentPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: Center(child: Text('Payment Page')),
    );
  }
}