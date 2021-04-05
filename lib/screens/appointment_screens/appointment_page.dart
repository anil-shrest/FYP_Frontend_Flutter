import 'dart:convert';

import 'package:DentalHome/components/providers.dart';
import 'package:DentalHome/models/appoint.dart';
import 'package:DentalHome/screens/payment_screen/khalti_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appoint_view_screen.dart';

//  Appointment page creation
class AppointmentPageScreen extends StatefulWidget {
  @override
  _AppointmentPageScreenState createState() => _AppointmentPageScreenState();
}

class _AppointmentPageScreenState extends State<AppointmentPageScreen> {
  final doctorController = TextEditingController();
  final appointTimeController = TextEditingController();

  List<String> _doctorList = [];
  List<int> _doctorId = [];
  List<String> _timeList = [];
  Map<int, String> doctorMap = {};
  List _selectedIndex = [];

  String csv;
  String doc;
  int staffId;
  String _selectedDoctor;
  String bookedTime;
  String ddlTitle = 'Select a doctor';
  String ddlValue;
  int selectedIndex;
  int timeIndex = 0;
  int timeId = 0;

  var selectedTimeSlot;
  var docId;
  var docName;
  var timeLabelColor = Colors.white;
  var dt = DateTime.now();

  bool _enabled = true;
  bool _shouldIgnore = false;

  @override
  void initState() {
    super.initState();
    _selectedDoctor = null;
    _getDoctorlist();
    // _getBookedTime();
  }

  // Getting doctor's name and storing in a list to display in drop down list
  _getDoctorlist() {
    final doctorProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    for (int i = 0; i < doctorProvider.doctor.length; i++) {
      print('this is the list :' + doctorProvider.doctor[i].full_name);
      _doctorList.add(doctorProvider.doctor[i].full_name);
      _doctorId.add(doctorProvider.doctor[i].id);
      // print('Doc id is -->');
      // print(doctorProvider.doctor[i].id);
    }
    // Maping doctor id and name
    doctorMap = Map.fromIterables(_doctorId, _doctorList);
  }

  // Getting time table and storing in a list to display in chip
  _getTimeTablelist() {
    // final staffProvider = Provider.of<Providers>(context);
    final timeProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    staffId = timeProvider.timeTable[timeIndex].author.id;
    csv = timeProvider.timeTable[timeIndex].timeSpace;
    // ? timeProvider.timeTable[timeIndex].timeSpace
    // : timeProvider.timeTable[timeIndex].timeSpace;
    _timeList = csv.split(new RegExp(r","));
    // staffProvider.setStaffId(staffId);
    // print(staffId);
  }

  // Getting the time of appointment booked to disbale it for a day
  _getBookedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //DateTime.parse because you can only save Strings locally.
    // .add Adds the time limit we wanr for demo only 3 minutes
    var _date = DateTime.parse(prefs.getString('lastPressed'))
        .add(Duration(minutes: 1));

    if (_date.isBefore(DateTime.now())) {
      _shouldIgnore = false;
    } else {
      _shouldIgnore = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _getBookedTime();
    _getTimeTablelist();
    // int timeId = 0;
    // _getDoctorlist();
    // print(doc);
    final paymentProvider = Provider.of<Providers>(context);
    final appointProvider = Provider.of<AppointmentProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 35),
            Container(
              child: Text('Book your appointment \ntoday.',
                  style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: size.width * 0.92,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      // "https://i.pinimg.com/originals/1b/f4/37/1bf43723e3f0ba5c0933f490eff27cf9.jpg"
                      "https://image.freepik.com/foto-gratis/herramientas-cuidado-dental-sobre-superficie-blanca_185193-15011.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5.0),
                // color: Color(0xFF50d1a8),
                color: Colors.blueGrey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: SvgPicture.asset('assets/men_icon.svg')),
                          SizedBox(width: 20.0),
                          Text(
                            'Select the appropriate details below',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: buttonColor,
                                letterSpacing: 0.3),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45.0, vertical: 10.0),
                        child: Text(
                          'Today ' + DateFormat.yMMMEd().format(dt),
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 25.0,
                                width: 25.0,
                                child: SvgPicture.asset('assets/doc_icon.svg')),
                            SizedBox(width: 20.0),
                            Text(
                              ddlTitle,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: buttonColor,
                                  letterSpacing: 0.2),
                            )
                          ]),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45.0),
                        child: DropdownButton<String>(
                          value: _selectedDoctor,
                          iconSize: 30.0,
                          // icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700),
                          underline: Container(
                            height: 1,
                            color: Colors.deepPurpleAccent,
                          ),
                          iconEnabledColor: Colors.teal[400],
                          items: doctorMap
                              .map((description, value) {
                                return MapEntry(
                                    description,
                                    DropdownMenuItem<String>(
                                      // value: description.toString(),
                                      value: value + description.toString(),
                                      child: Text("$value  D$description"),
                                    ));
                              })
                              .values
                              .toList(),
                          onChanged: (String newVal) {
                            setState(() {
                              _selectedDoctor = newVal;
                              // ddlTitle = '';
                              // ddlValue =
                              timeId += 1;
                              docId =
                                  newVal.replaceAll(new RegExp(r'[^0-9]'), '');
                              docName = newVal.replaceAll(
                                  new RegExp(r'[^a-zA-Z. ]'), '');
                              doc = docName;
                              // timeIndex = _doctorList.indexOf(newVal);
                              print(int.parse(docId));
                              print(docName);
                              timeIndex = _doctorList.indexOf(docName);
                            });
                            // print(_selectedDoctor);
                            // print(newVal);
                            print(timeIndex);
                          },
                          // items: _doctorList.map((doctor) {
                          //   return DropdownMenuItem(
                          //     child: new Text(doctor.toString()),
                          //     value: doctor,
                          //   );
                          // }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: SvgPicture.asset('assets/appoint_icon.svg')),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          'Select the viable time slot for your appointment',
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: buttonColor,
                              letterSpacing: 0.3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _timeList.length,
                        itemBuilder: (ctx, i) {
                          final _isSelected = _selectedIndex.contains(i);
                          return GestureDetector(
                            onTap: () {
                              print('button number is $i');
                              setState(() {
                                selectedIndex = i;
                                selectedTimeSlot = _timeList[i];
                                print(selectedTimeSlot);
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                // padding: EdgeInsets.all(10),
                                width: 106.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedIndex == i
                                      ? Color(0xFF00d1a8)
                                      : Colors.white,
                                  border: Border.all(
                                      color: selectedIndex == i
                                          ? Colors.teal
                                          : Colors.teal,
                                      width: 1.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5.0)), // set rounded corner radius
                                ),
                                child: Text(
                                  _timeList[i],
                                  style: TextStyle(
                                      color: selectedIndex == i
                                          ? Colors.white
                                          : Colors.black54,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Center(
              child: IgnorePointer(
                ignoring: _shouldIgnore,
                child: FlatButton(
                  height: 45.0,
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    paymentProvider.setBookingAmount(500);
                    appointProvider.staff_fcm(13);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KhaltiScreen()));
                    setState(() {
                      _lockButton();
                    });
                    //to get the fk of doctor
                    String result = _selectedDoctor.substring(
                        0, _selectedDoctor.indexOf(' '));
                    print(result);
                    appointProvider.addAppointment(
                        selectedTimeSlot, int.parse(docId));
                    // FOR APPOINTMENT POST 1st WAY
                    // if (_selectedDoctor.isNotEmpty &&
                    //     selectedTimeSlot != null) {
                    //   final Appointment appointment = Appointment(
                    //       appointmentBy: _selectedDoctor,
                    //       appointmentTime: selectedTimeSlot);
                    //   Provider.of<AppointmentProvider>(context, listen: false)
                    //       .addAppointment(appointment);
                    // } else {
                    //   print('Failed to add appoint');
                    // }
                    print('tap');
                    print(selectedTimeSlot);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AppointHomePage()));
                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(color: buttonTextColor, fontSize: 15.0),
                  ),
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_lockButton() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var _date = DateTime.now();
  await prefs.setString('lastPressed', _date.toString());
}

// //  Labels for different time period creation
// class TimeLabel extends StatefulWidget {
//   @override
//   _TimeLabelState createState() => _TimeLabelState();
// }

// class _TimeLabelState extends State<TimeLabel> {
//   List _selectedIndex = [];
//   List cs = [];
//   int selectedIndex;
//   String selectedTimeSlot;
//   // var timeList = [
//   //   '10:30 AM',
//   //   '11:30 AM',
//   //   '12:00 PM',
//   //   '12:30 PM',
//   //   '1:30 PM',
//   //   '2:00 PM',
//   //   '3:00 PM',
//   //   '4:00 PM',
//   //   '5:00 PM',
//   //   '5:30 PM'
//   // ];
//   bool _enabled = true;

//   @override
//   void initState() {
//     super.initState();
//     // _selectedDoctor = null;
//     _getTimeTablelist();
//   }

//   // Getting time table and storing in a list to display in chip
//   _getTimeTablelist() {
//     final timeProvider =
//         Provider.of<AppointmentProvider>(context, listen: false);
//     print(timeProvider.timeTable[0].time_space);
//     cs.add(timeProvider.timeTable[0].time_space.split(", "));
//     print('csv is: $cs');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final timeProvider = Provider.of<AppointmentProvider>(context);
//     _getTimeTablelist();
//     print('wth');
//     return SizedBox(
//       height: 60.0,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: cs.length,
//           // itemCount: timeProvider.fetchTimeTable.le,
//           itemBuilder: (ctx, i) {
//             final _isSelected = _selectedIndex.contains(i);
//             return GestureDetector(
//               onTap: () {
//                 print('button number is $i');
//                 print('CSV val is ->' + cs[i]);
//                 setState(() {
//                   selectedIndex = i;
//                   selectedTimeSlot = cs[i];
//                   print(selectedTimeSlot);
//                   // if (_enabled) {
//                   //   _selectedIndex.remove(i);
//                   //   _enabled = false;
//                   //   // _firstPress = false;
//                   // } else {
//                   //   _selectedIndex.add(i);
//                   // }
//                 });
//               },
//               child: Container(
//                   margin: EdgeInsets.all(10),
//                   // padding: EdgeInsets.all(10),
//                   width: 106.0,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color:
//                         selectedIndex == i ? Color(0xFF00d1a8) : Colors.white,
//                     border: Border.all(
//                         color: selectedIndex == i ? Colors.teal : Colors.teal,
//                         width: 1.0), // set border width
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(5.0)), // set rounded corner radius
//                   ),
//                   child: Text(
//                     cs[1],
//                     // timeProvider.timeTable[i].time_space,
//                     style: TextStyle(
//                         color:
//                             selectedIndex == i ? Colors.white : Colors.black54,
//                         fontWeight: FontWeight.bold),
//                   )),
//             );
//           }),
//     );
//   }
// }
