import 'package:flutter/material.dart';


class DoctorPageScreen extends StatefulWidget {
  @override
  _DoctorPageScreenState createState() => _DoctorPageScreenState();
}

class _DoctorPageScreenState extends State<DoctorPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(child: Text('Doctor Page')),
    );
  }
}