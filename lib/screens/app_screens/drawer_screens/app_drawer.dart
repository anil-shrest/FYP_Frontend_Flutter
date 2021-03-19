import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash_screen.dart';

class AppDrawer extends StatefulWidget {
  final Function onTap;

  AppDrawer({this.onTap});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isStaff = false;

  _getStaffStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isStaff = preferences.getBool('is_staff');
    });
  }

  @override
  void initState() {
    _getStaffStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300.0,
                child: DrawerHeader(
                  child: Text(''),
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/drawer_bg.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: () => widget.onTap(context, 0),
              ),
              ListTile(
                leading: Icon(Icons.medical_services),
                title: Text('Appointment'),
                onTap: () => widget.onTap(context, 1),
              ),
              ListTile(
                leading: Icon(Icons.watch),
                title: Text('Set Reminder'),
                onTap: () => widget.onTap(context, 2),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => widget.onTap(context, 3),
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.redAccent),
                ),
                // onTap: () => widget.onTap(context, 4),
                onTap: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  print(sharedPreferences.getString('token'));
                  sharedPreferences.remove('token');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SplashScreen()),
                      (Route<dynamic> route) => false);
                  _showToastMessage("See you later");
                },
              ),
            ],
          ),
        ));
  }

// to display toast message
  _showToastMessage(String message) {
    return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.teal[300],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
