import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/screens/app_screens/main_menu_page.dart';

import 'screens/app_screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) => AppointmentProvider(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.deepPurple,
    //       // visualDensity: VisualDensity.adaptivePlatformDensity,
    //     ),
    //     // home: MainMenu(),
    //     home: SplashScreen(),
    //   ),
    // );
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ChangeNotifierProvider(create: (context) => Providers()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: SplashScreen(),
        ));
  }
}
