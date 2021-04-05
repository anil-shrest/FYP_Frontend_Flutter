import 'dart:convert';

import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SetTimeScreen extends StatefulWidget {
  @override
  _SetTimeScreenState createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  List<String> _doctorList = [];
  List<int> _doctorId = [];
  List<String> _timeList = [];

  Map<int, String> doctorMap = {};

  TextEditingController timeController = new TextEditingController();

  String _selectedDoctor;
  String csv;
  String hintText = '1:00 PM, 1:45 PM';
  String ddlTitle = 'Select a doctor';
  int timeIndex = 0;

  // Getting doctor's name and storing in a list to display in drop down list
  _getDoctorlist() {
    final doctorProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    for (int i = 0; i < doctorProvider.doctor.length; i++) {
      // print('this is the list :' + doctorProvider.doctor[i].full_name);
      _doctorList.add(doctorProvider.timeTable[i].doctor.fullName);
      _doctorId.add(doctorProvider.timeTable[i].id);
    }
    // Maping doctor id and name
    doctorMap = Map.fromIterables(_doctorId, _doctorList);
    // print(doctorMap);
  }

  @override
  void initState() {
    super.initState();
    _getDoctorlist();
  }

  // Getting time table and storing in a list to display in chip
  _getTimeTablelist() {
    final timeProvider = Provider.of<AppointmentProvider>(context);
    csv = timeProvider.timeTable[timeIndex].timeSpace;
    _timeList = csv.split(new RegExp(r","));
  }

  @override
  Widget build(BuildContext context) {
    // _getDoctorlist();
    final timeProvider = Provider.of<AppointmentProvider>(context);
    // _getTimeTablelist();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Doctor Time',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: buttonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child: Text('Set time table for doctors')),
            Container(child: Text('Choose the doctor')),
            DropdownButton<String>(
              value: _selectedDoctor,
              iconSize: 30.0,
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
              onChanged: (String newVal) {
                setState(() {
                  _selectedDoctor = newVal;
                  // ddlTitle = '';
                  // timeIndex = _doctorList.indexOf(newVal);
                });
                print(_selectedDoctor);
                // print(timeIndex);
              },
              items: doctorMap
                  .map((description, value) {
                    return MapEntry(
                        description,
                        DropdownMenuItem<String>(
                          // value: description.toString(),
                          value: description.toString(),
                          child: Text(value),
                        ));
                  })
                  .values
                  .toList(),
            ),
            TextFormField(
              // initialValue: csv,
              controller: timeController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText,
                labelText: 'Set Time',
                labelStyle: TextStyle(color: Colors.grey[800]),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: primaryColor,
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black87,
                )),
              ),
              // decoration: InputDecoration(
              //   hoverColor: Colors.teal,
              //   enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(
              //       color: Colors.blueAccent,
              //     ),
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   hintText: "Enabled decoration text ...",
              // )
            ),
            FlatButton(
              height: 45.0,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                print('tap');
                print(_selectedDoctor);
                timeProvider.updateTimeTable(
                    timeController.text, int.parse(_selectedDoctor));
              },
              child: Text(
                'Update',
                style: TextStyle(color: buttonTextColor, fontSize: 15.0),
              ),
              color: primaryColor,
            ),
            // FlatButton(
            //   height: 45.0,
            //   minWidth: MediaQuery.of(context).size.width,
            //   onPressed: () async {
            //     print('tap');
            //     addTimeTable(timeController.text, int.parse(_selectedDoctor));
            //   },
            //   child: Text(
            //     'Save',
            //     style: TextStyle(color: buttonTextColor, fontSize: 15.0),
            //   ),
            //   color: primaryColor,
            // ),
          ],
        ),
      ),
    );
  }

  Future<String> addTimeTable(String time_space, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final url = "http://10.0.2.2:8000/time_table/add/$id/";
    final response = await http.post(url,
        headers: <String, String>{
          'Content-type': 'application/json',
          "Authorization": "Token $token"
        },
        body: jsonEncode(<String, dynamic>{
          'time_space': time_space,
        }));
    if (response.statusCode == 200) {
      _showToastMessage('Time successfully assigned', Colors.teal[400]);
      return 'success';
    } else {
      _showToastMessage(
          'Doctor has already been assigned time', Colors.redAccent[200]);
      return 'failure';
    }
  }

  // To show appropriate toast message
  _showToastMessage(String message, Color color) {
    return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
