import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';

class AppointHomePage extends StatefulWidget {
  // bool _appointmentTaken = false;

  @override
  _AppointHomePageState createState() => _AppointHomePageState();
}

class _AppointHomePageState extends State<AppointHomePage> {
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

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
    int list_count = appointmentProvider.appointment.length;
    Size size = MediaQuery.of(context).size;
    print('No. of appointments: $list_count');
    return Scaffold(
      body: list_count != null
          ? SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: appointmentProvider.appointment.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          appointmentProvider.appointment[index].appointmentBy,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          appointmentProvider
                              .appointment[index].appointmentTime,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        leading:
                            Icon(Icons.calendar_today, color: Colors.grey[600]),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.black54,
                        ),
                        onTap: () {},
                        // trailing: IconButton(
                        //     icon: Icon(Icons.delete, color: Colors.red),
                        //     onPressed: () {
                        //       appointmentProvider.deleteAppoint(
                        //           appointmentProvider.appointment[index]);
                        //     }),
                      );
                    },
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
