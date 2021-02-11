import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/components/text.dart';
import 'components/theme.dart';
import 'screens/app_screens/splash_screen.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppointmentProvider()),
    ChangeNotifierProvider(create: (context) => Providers()),
    ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
    ChangeNotifierProvider(create: (context) => PageProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
// INITIAL WAS
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

// AND IT WAS
    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(create: (context) => AppointmentProvider()),
    //       ChangeNotifierProvider(create: (context) => Providers()),
    //       ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    //     ],
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: Provider.of<ThemeNotifier>(context).currentThemeData,
    //       home: SplashScreen(),
    //     ));

// NOW IT IS LIKE
    // DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Provider.of<ThemeNotifier>(context, listen: false).currentThemeData,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // home: MainMenu(),
      home: SplashScreen(),
    );
  }
}
