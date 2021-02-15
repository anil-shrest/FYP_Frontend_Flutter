// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simpleApi/components/text.dart';

// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   // bool isSwitched = false;
//   SharedPreferences sharedPreferences;

//   @override
//   void initState() {
//     // to get the status of switch at start
//     getSwitchStatus();
//     super.initState();
//   }

//   // future to check the state of switch button
//   Future<bool> saveSwitchStatus(bool value) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool('switchState', value);
//     print('Switch value saved: $value');

//     return sharedPreferences.setBool('switchState', value);
//   }

//   Future<bool> getSwitchStatus() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     bool status = sharedPreferences.getBool('switchState');

//     return status;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var pageProvider = Provider.of<PageProvider>(context);
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Settings'),
//       // ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Change font size'),
//             ),
//             SizedBox(height: 15),
//             ListTile(
//               title: Text('${pageProvider.fontSize.toInt()}'),
//               subtitle: Slider(
//                 value: pageProvider.sliderFontSize,
//                 min: 0.5,
//                 onChanged: (newValue) {
//                   pageProvider.fontSize = newValue;
//                 },
//               ),
//             ),
//             SizedBox(height: 30),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('Dark Mode'),
//                 ),
//                 SizedBox(width: 15),
//                 Switch(
//                   value: pageProvider.isSwitchOn,
//                   onChanged: (value) {
//                     setState(() {
//                       pageProvider.isSwitchOn = value;
//                       saveSwitchStatus(value);
//                     });
//                     print('Btn saved state is: $pageProvider.isSwitchOn');
//                     // Provider.of<ThemeNotifier>(context, listen: false)
//                     //     .switchTheme();
//                   },
//                   activeTrackColor: Colors.deepPurple,
//                   activeColor: Colors.white,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// NEW TRY
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/components/color_theme.dart';
import 'package:simpleApi/components/theme.dart';

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
      // appBar: AppBar(
      //   title: Text('demo'),
      // ),
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
            // shape: ,
            tileColor: Colors.black12,
            title: Text('Dark Theme'),
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
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
