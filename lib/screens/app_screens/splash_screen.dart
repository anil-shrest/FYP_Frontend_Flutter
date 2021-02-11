import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/screens/app_screens/main_menu_page.dart';
import 'package:simpleApi/screens/appointment_screens/appoint_view_screen.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String finalUsername;

  @override
  void initState() {
    // super.initState();
    getValidationData().whenComplete(() async {
      Timer(
          Duration(seconds: 2),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => finalUsername == null
                      // ? LoginPage()
                      ? LandingPage()
                      : MainMenu())));
    });

    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String obtainedUsername = sharedPreferences.getString('token');
    setState(() {
      finalUsername = obtainedUsername;
    });
    print('Token of the user is: $finalUsername');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 60.0,
          width: 60.0,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
