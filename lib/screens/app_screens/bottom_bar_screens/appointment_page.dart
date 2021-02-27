import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/components/colors.dart';

//  Appointment page creation
class AppointmentPageScreen extends StatefulWidget {
  @override
  _AppointmentPageScreenState createState() => _AppointmentPageScreenState();
}

class _AppointmentPageScreenState extends State<AppointmentPageScreen> {
  String ddlTitle = 'Select a doctor';
  var dt = DateTime.now();
  List<String> _doctors = [];
  String _selectedDoctor;
  var timeLabelColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _selectedDoctor = null;
    _getdoctorlist();
  }

  // Getting doctor's name to display in drop down list
  _getdoctorlist() {
    final doctorProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    for (int i = 0; i < doctorProvider.doctor.length; i++) {
      print('this is the list :' + doctorProvider.doctor[i].full_name);
      _doctors.add(doctorProvider.doctor[i].full_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(newDt); // Fri, Apr 3, 2021
    // final doctorProvider = Provider.of<AppointmentProvider>(context);
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
                      "https://i.pinimg.com/originals/1b/f4/37/1bf43723e3f0ba5c0933f490eff27cf9.jpg"),
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
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            letterSpacing: 0.3),
                      ),
                      // SizedBox(width: 20.0),
                      DropdownButton<String>(
                        value: _selectedDoctor,
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconEnabledColor: Colors.teal,
                        onChanged: (String newVal) {
                          setState(() {
                            _selectedDoctor = newVal;
                            ddlTitle = '';
                          });
                          print(_selectedDoctor);
                        },
                        items: _doctors.map((doctor) {
                          return DropdownMenuItem(
                            child: new Text(doctor.toString()),
                            value: doctor,
                          );
                        }).toList(),
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
                  // SizedBox(height: 10.0),
                  TimeLabel(),
                ],
              ),
            ),
            Center(
              child: FlatButton(
                height: 45.0,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {},
                child: Text(
                  'Book Now',
                  style: TextStyle(color: buttonTextColor, fontSize: 15.0),
                ),
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//  Labels for different time period creation
class TimeLabel extends StatefulWidget {
  @override
  _TimeLabelState createState() => _TimeLabelState();
}

class _TimeLabelState extends State<TimeLabel> {
  List _selectedIndex = [];
  int selectedIndex;
  String selectedTimeSlot;
  var timeList = [
    '10:30 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '1:30 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '5:30 PM'
  ];
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: timeList.length,
          itemBuilder: (ctx, i) {
            final _isSelected = _selectedIndex.contains(i);
            return GestureDetector(
              onTap: () {
                print('button number is $i');
                setState(() {
                  selectedIndex = i;
                  selectedTimeSlot = timeList[i];
                  print(selectedTimeSlot);
                  // if (_enabled) {
                  //   _selectedIndex.remove(i);
                  //   _enabled = false;
                  //   // _firstPress = false;
                  // } else {
                  //   _selectedIndex.add(i);
                  // }
                });
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  // padding: EdgeInsets.all(10),
                  width: 106.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == i ? Color(0xFF00d1a8) : Colors.white,
                    border: Border.all(
                        color: selectedIndex == i ? Colors.teal : Colors.teal,
                        width: 1.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0)), // set rounded corner radius
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 8,
                    //       color: Colors.grey[500],
                    //       offset: Offset(1, 3))
                    // ] // make rounded corner of border
                  ),
                  child: Text(
                    timeList[i],
                    style: TextStyle(
                        color:
                            selectedIndex == i ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.bold),
                  )),
            );
          }),
    );
  }
}
