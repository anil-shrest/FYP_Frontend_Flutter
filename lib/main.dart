import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/screens/loginPage.dart';
import 'package:simpleApi/screens/splash_screen.dart';

import 'screens/addAppoint.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: LoginPage(),
        home: SplashScreen(),
      ),
    );
  }
}

