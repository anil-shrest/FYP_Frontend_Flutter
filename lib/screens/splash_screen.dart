import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/screens/AppointViewScreen.dart';
import 'package:simpleApi/screens/landingPage.dart';
import 'package:simpleApi/screens/loginPage.dart';

String finalUsername;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                      : AppointHomePage())));
    });

    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    setState(() {
      finalUsername = obtainedUsername;
    });
    print(finalUsername);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            elevation: 30.0,
            shadowColor: Colors.grey[600],
            margin: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
