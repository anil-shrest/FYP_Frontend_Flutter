import 'package:flutter/material.dart';
import 'doctor_list.dart';

// Combining all the views for doctors
class DoctorMainScreen extends StatefulWidget {
  @override
  _DoctorMainScreenState createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorList(),
        ],
      ),
    );
  }
}


