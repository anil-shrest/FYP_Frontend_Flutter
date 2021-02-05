import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/appointment_page.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/doctor_page.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/home_page.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/payment_page.dart';
import 'package:simpleApi/screens/app_screens/settings_page.dart';
import 'package:simpleApi/screens/appointment_screens/appoint_view_screen.dart';

import 'drawer_screens/app_drawer.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _index = 0;
  int index = 0;

  List<Widget> list = [
    MainMenu(),
    AppointHomePage(),
    SettingsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: SvgPicture.asset('assets/menu_icon.svg'),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: Text(
              "Track your Shipment",
            ),
            backgroundColor: Colors.transparent,
            // backgroundColor: Color(0x44000000),
            elevation: 0,
            actions: [
              // IconButton(
              //   icon: SvgPicture.asset('assets/search_icon.svg'),
              //   onPressed: () {
              //     // do something
              //   },
              // ),
              IconButton(
                icon: SvgPicture.asset('assets/profile_logo.svg'),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(
                icon: SvgPicture.asset('assets/map_icon.svg'),
                onPressed: () {
                  // do something
                },
              ),
            ],
          ),
          drawer: AppDrawer(onTap: (ctx, i) {
            setState(() {
              index = i;
              Navigator.pop(ctx);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => ctx));
            });
          }),
          body: index == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Changing the page according to the selected index
                    Expanded(
                        child: _index == 0
                            ? HomePageScreen()
                            : (_index == 1
                                ? DoctorPageScreen()
                                : (_index == 2
                                    ? AppointmentPageScreen()
                                    : (_index == 3
                                        ? PaymentPageScreen()
                                        : HomePageScreen())))),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, left: 18.0, right: 18, bottom: 3.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: _index == 0
                                      ? buttonColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: _index == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _index == 0 ? 'Home' : '',
                                        style: TextStyle(
                                          color: _index == 0
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 1;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: _index == 1
                                      ? buttonColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: _index == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _index == 1 ? 'Doctor' : '',
                                        style: TextStyle(
                                          color: _index == 1
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 2;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: _index == 2
                                      ? buttonColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.list_alt,
                                      color: _index == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _index == 2 ? 'Appointment' : '',
                                        style: TextStyle(
                                          color: _index == 2
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 3;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: _index == 3
                                      ? buttonColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on_outlined,
                                      color: _index == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _index == 3 ? 'Payment' : '',
                                        style: TextStyle(
                                          color: _index == 3
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : list[index]),
    );
  }
}
