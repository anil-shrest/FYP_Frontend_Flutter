import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/components/color_theme.dart';
import 'package:DentalHome/components/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 50.0),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1),
              )),
          ListTile(
            tileColor: Colors.black12,
            title: Text('Dark Theme',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            contentPadding: const EdgeInsets.only(left: 16.0),
            leading: Icon(
              Icons.wb_sunny_outlined,
              color: Colors.orange,
            ),
            trailing: Transform.scale(
              scale: 0.4,
              child: DayNightSwitch(
                value: _darkTheme,
                onChanged: (val) {
                  setState(() {
                    _darkTheme = val;
                  });
                  onThemeChanged(val, themeNotifier);
                },
              ),
            ),
          ),
          SizedBox(height: 5.0),
          ListTile(
            tileColor: Colors.black12,
            title: Text('Give Feedbacks',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            contentPadding: const EdgeInsets.only(left: 16.0),
            leading: Icon(
              Icons.rate_review,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 5.0),
          ListTile(
            onTap: () {
              _showDialog();
            },
            tileColor: Colors.black12,
            title: Text('About App',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
            contentPadding: const EdgeInsets.only(left: 16.0),
            leading: Icon(
              Icons.info_outline,
              color: Colors.teal,
            ),
          )
        ],
      ),
    );
  }

  //  To change the theme
  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  // Dialog for auth confirmation
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dental Home Nepal v1.0.0'),
            content: Text(
                'This is an application made for dental home to provide easy services to their customers. This application is a final year project which is carried out by Developer -Anil'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
