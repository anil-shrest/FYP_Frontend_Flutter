import 'package:flutter/material.dart';

class AppointmentPageScreen extends StatefulWidget {
  @override
  _AppointmentPageScreenState createState() => _AppointmentPageScreenState();
}

class _AppointmentPageScreenState extends State<AppointmentPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(child: Text('Appointment Page')),
    );
  }
}