import 'package:flutter/material.dart';

class SetReminderPage extends StatefulWidget {
  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.purpleAccent,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        // appBar: AppBar(title: Text('Settings')),
        body: Center(child: Text('Set Reminder Page')),
      ),
    );
  }
}
