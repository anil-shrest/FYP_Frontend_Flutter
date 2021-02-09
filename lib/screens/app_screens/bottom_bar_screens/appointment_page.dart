import 'package:flutter/material.dart';
import 'package:simpleApi/components/colors.dart';

class AppointmentPageScreen extends StatefulWidget {
  @override
  _AppointmentPageScreenState createState() => _AppointmentPageScreenState();
}

class _AppointmentPageScreenState extends State<AppointmentPageScreen> {
  String doctor_ddl = 'Dr. Sunita Joshi';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text('Book your appointment \ntoday.',
                    style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 15.0),
              Center(
                child: Container(
                  width: size.width * 0.92,
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select the appropriate details below'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 20.0),
                            DropdownButton<String>(
                              value: doctor_ddl,
                              icon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Icon(Icons.add),
                              ),
                              onChanged: (String newVal) {
                                setState(() {
                                  doctor_ddl = newVal;
                                });
                              },
                              items: <String>[
                                'Dr. Sunita Joshi',
                                'Dr. Hari Thapa',
                                'Dr. Anita Manandhar'
                              ].map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Text('Select time for appointment:'),
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                color: Color(0xFFD9DCF9),
                              ),
                              child: Center(
                                  child: Text(
                                '10:30 PM',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          ],
                        ),
                        FlatButton(
                          minWidth: size.width * 0.89,
                          // padding: EdgeInsets.symmetric(horizontal: 120.0),
                          onPressed: () {},
                          child: Text(
                            'BOOK APPOINTMENT',
                            style: TextStyle(
                                color: buttonTextColor, fontSize: 15.0),
                          ),
                          color: primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
