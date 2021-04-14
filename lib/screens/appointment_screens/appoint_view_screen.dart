import 'package:DentalHome/components/providers.dart';
import 'package:DentalHome/screens/app_screens/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:DentalHome/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointHomePage extends StatefulWidget {
  // bool _appointmentTaken = false;

  @override
  _AppointHomePageState createState() => _AppointHomePageState();
}

class _AppointHomePageState extends State<AppointHomePage> {
  bool isStaff = false;
  String time;
  DateTime dateNow = DateTime.now();

  // to show toast message
  _showToastMessage(String message) {
    return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[500],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  //  to get staff status
  _getStaffStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final staffStatusProvider = Provider.of<Providers>(context, listen: false);
    staffStatusProvider.setStaffStatus(preferences.getBool('is_staff'));
    // setState(() {
    isStaff = staffStatusProvider.staffStatus;
    // });
  }

  _dateTime() {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
  }

  @override
  void initState() {
    super.initState();
    _getAppointments();
  }

// get all the appointments
  _getAppointments() {
    final appointProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    appointProvider.fetchAppointment();
  }

  @override
  Widget build(BuildContext context) {
    _getAppointments();
    // _getStaffStatus();
    // final staffStatusProvider = Provider.of<Providers>(context);
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    int list_count = appointmentProvider.appointment.length;
    Size size = MediaQuery.of(context).size;
    // print('No. of appointments: $list_count');
    return Scaffold(
      body: list_count != null
          ? SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Appointment History',
                      style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: appointmentProvider.appointment.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DateTime now = DateTime.now();
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted = formatter.format(now);
                        // print(formatted); // something like 2013-04-20

                        final savedDate =
                            appointmentProvider.appointment[index].createdAt;
                        DateTime tempDate =
                            new DateFormat("yyyy-MM-dd").parse(savedDate);
                        DateFormat formatDate = DateFormat('yyyy-MM-dd');
                        // print(formattedDate);
                        final String displayDate = formatDate.format(tempDate);
                        // print(displayDate);
                        final dateIs = dateNow.difference(tempDate).inDays;
                        return ListTile(
                          title: Text(
                            dateIs <= 1 ? 'Today' : displayDate,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            appointmentProvider.appointment[index].doctor,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          leading: Icon(Icons.calendar_today,
                              color: Colors.grey[600]),
                          trailing: dateIs <= 1
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                    size: 32.0,
                                  ),
                                )
                              : null,
                          // trailing: IconButton(
                          //     icon: Icon(Icons.delete, color: Colors.red),
                          //     onPressed: () {
                          //       appointmentProvider.deleteAppoint(
                          //           appointmentProvider.appointment[index]);
                          //     }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: size.width * 0.6,
                      child: SvgPicture.asset(
                        'assets/no_appoint.svg',
                        fit: BoxFit.contain,
                      )),
                  Container(
                    height: 40.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[600]),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Center(child: Text('No Appointments')),
                  ),
                ],
              ),
            ),
    );
  }
}
