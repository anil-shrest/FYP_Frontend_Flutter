import 'package:flutter/material.dart';

class SetTimeScreen extends StatefulWidget {
  @override
  _SetTimeScreenState createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Center(child: Text('View Timer')),),
    );
  }
}