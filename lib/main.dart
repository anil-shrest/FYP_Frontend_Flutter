import 'package:DentalHome/screens/firebase_cloud_messaging/fcm_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/color_theme.dart';
import 'package:DentalHome/components/providers.dart';
import 'package:DentalHome/components/text.dart';
import 'components/theme.dart';
import 'screens/app_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// void main() async {
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(create: (context) => AppointmentProvider()),
//     ChangeNotifierProvider(create: (context) => Providers()),
//     ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
//     ChangeNotifierProvider(create: (context) => PageProvider()),
//   ], child: MyApp()));
// }

Future<void> main() async {
  // Initializing local notification
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var initializationSettingsAndroid = AndroidInitializationSettings('logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppointmentProvider()),
      ChangeNotifierProvider(create: (context) => Providers()),
      ChangeNotifierProvider(
          create: (context) =>
              ThemeNotifier(darkModeOn ? darkTheme : lightTheme)),
      ChangeNotifierProvider(create: (context) => PageProvider()),
    ], child: MyApp()));
  });
}

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['status'];
  return item;
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

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      // theme: ThemeData(primarySwatch: Colors.deepPurple),
      // home: MainMenu(),
      home: SplashScreen(),
    );
  }
}
