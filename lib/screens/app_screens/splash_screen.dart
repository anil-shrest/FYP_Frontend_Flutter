import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/screens/app_screens/main_menu_page.dart';
import 'package:DentalHome/screens/appointment_screens/appoint_view_screen.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String finalUsername;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // super.initState();
    _fcm();
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

  // To show appropriate toast message
  _showToastMessage(String message, Color color) {
    return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void _fcm() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showToastMessage('An appointment has been placed', Colors.teal[300]);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
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
          height: 70.0,
          width: 70.0,
          child: SvgPicture.asset(
            'assets/logo.svg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
