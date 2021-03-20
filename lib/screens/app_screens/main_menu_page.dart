import 'package:DentalHome/screens/staff_screens/set_time.dart';
import 'package:DentalHome/screens/staff_screens/view_appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:DentalHome/components/providers.dart';
import 'package:DentalHome/screens/app_screens/settings_page.dart';
import 'package:DentalHome/screens/appointment_screens/appoint_view_screen.dart';
import 'package:DentalHome/screens/appointment_screens/appointment_page.dart';
import 'package:DentalHome/screens/doctor_screens/doctor_main_page.dart';
import 'package:DentalHome/screens/map_screen/maps.dart';
import 'package:DentalHome/screens/payment_screen/payment_page.dart';
import 'package:DentalHome/screens/user_screen/profile_screen.dart';
import 'bottom_bar_screens/HOME/home_page.dart';
import 'drawer_screens/app_drawer.dart';
import 'drawer_screens/set_reminder_page.dart';
import 'splash_screen.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _index = 0;
  int index = 0;
  var themeVal;
  bool isStaff = false;

  List<Widget> list = [
    MainMenu(),
    AppointHomePage(),
    SetReminderPage(),
    SettingsPage(),
  ];

  _darkModeVal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // print('Staff status : -');
    // print(preferences.getBool('is_staff'));
    setState(() {
      themeVal = preferences.get('darkMode');
    });
  }

  _getStaffStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final staffStatusProvider = Provider.of<Providers>(context, listen: false);
    staffStatusProvider.setStaffStatus(preferences.getBool('is_staff'));
    // setState(() {
    isStaff = staffStatusProvider.staffStatus;
    // });
  }

  @override
  void initState() {
    super.initState();
    _getStaffStatus();
  }

  @override
  Widget build(BuildContext context) {
    _getStaffStatus();
    final staffStatusProvider = Provider.of<Providers>(context, listen: false);

    // print(isStaff);
    _darkModeVal();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // backgroundColor: buttonColor,
          leading: Builder(
            builder: (context) => IconButton(
              // icon: SvgPicture.asset('assets/menu_icon_p.svg'),
              icon: themeVal == true
                  ? SvgPicture.asset('assets/menu_icon_w.svg')
                  : SvgPicture.asset('assets/menu_icon.svg'),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/profile_logo.svg'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()));
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/map_icon.svg'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GoogleMapScreen()));
              },
            ),
          ],
        ),
        drawer: staffStatusProvider.staffStatus == false
            ? AppDrawer(onTap: (ctx, i) {
                setState(() {
                  index = i;
                  Navigator.pop(ctx);
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => ctx));
                });
              })
            : Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Center(
                        child: Text('Staff Panel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                letterSpacing: 0.1)),
                      ),
                      decoration: BoxDecoration(
                        color: buttonColor,
                      ),
                    ),
                    ListTile(
                      title: Text('View Appointments',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16.0,
                              letterSpacing: 0.1)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllAppointments()));
                      },
                    ),
                    ListTile(
                      title: Text('Set Time Table',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16.0,
                              letterSpacing: 0.1)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetTimeScreen()));
                      },
                    ),
                    ListTile(
                      title: Text('Logout',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16.0,
                              letterSpacing: 0.1)),
                      onTap: () async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        print(sharedPreferences.getString('token'));
                        sharedPreferences.remove('token');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SplashScreen()),
                            (Route<dynamic> route) => false);
                        // _showToastMessage("See you later");
                      },
                    ),
                  ],
                ),
              ),
        body: staffStatusProvider.staffStatus == false
            ? index == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Changing the page according to the selected index
                      Expanded(
                          child: _index == 0
                              ? HomePageScreen()
                              : (_index == 1
                                  ? DoctorMainScreen()
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
                                        ? Color(0xFF9871FD)
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
                                            ? Colors.grey[800]
                                            : buttonColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          _index == 0 ? 'Home' : '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
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
                                        ? Colors.teal[200]
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
                                            ? Colors.grey[800]
                                            : buttonColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          _index == 1 ? 'Doctor' : '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
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
                                        ? Colors.blue[200]
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
                                            ? Colors.grey[800]
                                            : buttonColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 7.0),
                                        child: Text(
                                          _index == 2 ? 'Appointment' : '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
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
                                        ? Colors.red[300]
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
                                            ? Colors.grey[800]
                                            : buttonColor,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 6.0),
                                        child: Text(
                                          _index == 3 ? 'Payment' : '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
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
                : list[index]
            : HomePageScreen());
  }
}
