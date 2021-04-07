import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:DentalHome/components/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ViewAllAppointments extends StatefulWidget {
  @override
  _ViewAllAppointmentsState createState() => _ViewAllAppointmentsState();
}

class _ViewAllAppointmentsState extends State<ViewAllAppointments> {
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

// get all the appointments
  _getAppointments() {
    final appointProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    appointProvider.fetchAllAppointment();
  }

  @override
  void initState() {
    super.initState();
    _getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<Providers>(context, listen: false);
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    int list_count = appointmentProvider.allAppointment.length;
    Size size = MediaQuery.of(context).size;
    print('No. of appointments: $list_count');
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'All Appointments',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: buttonColor),
      body: list_count != null
          ? SafeArea(
              child: Column(
                children: [
                  // SizedBox(height: 20.0),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: appointmentProvider.allAppointment.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            appointmentProvider.allAppointment[index].username,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            appointmentProvider.allAppointment[index].doctor,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          leading: Icon(Icons.calendar_today,
                              color: Colors.grey[600]),
                          // trailing: IconButton(
                          //     onPressed: () {
                          //       print(appointmentProvider
                          //           .allAppointment[index].id);
                          //       appointmentProvider.deleteAppoint(
                          //           appointmentProvider
                          //               .allAppointment[index].id);
                          //     },
                          //     icon: Icon(
                          //       Icons.delete,
                          //       color: Colors.red,
                          //     )),
                          // onTap: () {},
                          trailing: IconButton(
                              icon: Icon(Icons.domain_verification_sharp,
                                  color: Colors.red),
                              onPressed: () {
                                appointmentProvider.patient_fcm(
                                    appointmentProvider
                                        .allAppointment[index].id);
                                print(appointmentProvider
                                    .allAppointment[index].id);
                              }),
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
