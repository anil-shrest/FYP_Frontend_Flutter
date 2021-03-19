import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/screens/app_screens/landing_page.dart';
import 'package:simpleApi/screens/app_screens/main_menu_page.dart';
import 'package:simpleApi/screens/app_screens/settings_page.dart';
import 'package:simpleApi/screens/app_screens/splash_screen.dart';
import 'package:simpleApi/screens/appointment_screens/appoint_view_screen.dart';
import 'package:simpleApi/screens/auth_screens/login_page.dart';

// class HomeDrawer extends StatefulWidget {
//   @override
//   _HomeDrawerState createState() => _HomeDrawerState();
// }

// class _HomeDrawerState extends State<HomeDrawer> {
//   int index = 0;
//   List<Widget> list = [
//     MainMenu(),
//     AppointHomePage(),
//     LandingPage(),
//     SettingsPage(),
//     MainMenu()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: index == 0 ? MainMenu() : list[index],
//         drawer: AppDrawer(onTap: (ctx, i) {
//           setState(() {
//             index = i;
//             Navigator.pop(ctx);
//             // Navigator.push(
//             //     context, MaterialPageRoute(builder: (context) => ctx));
//           });
//         }),
//       ),
//     );
//   }
// }

class AppDrawer extends StatefulWidget {
  final Function onTap;

  AppDrawer({this.onTap});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
                // child: Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Center(
                //         child: Container(
                //           width: 80.0,
                //           height: 80.0,
                //           child: CircleAvatar(
                //             backgroundImage: AssetImage('assets/UserLogo.png'),
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 15.0),
                //       Center(
                //         child: Text(
                //           'Cristopher Max',
                //           style: TextStyle(
                //               fontSize: 15.0, fontWeight: FontWeight.w500),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
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
      ),
    );
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
