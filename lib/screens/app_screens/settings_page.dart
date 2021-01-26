import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.purpleAccent,
      home: Scaffold(
        backgroundColor: Colors.amberAccent,
        // appBar: AppBar(title: Text('Settings')),
        body: Center(child: Text('Settings')),
      ),
    );
  }
}
