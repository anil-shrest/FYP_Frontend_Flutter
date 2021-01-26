import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:simpleApi/screens/auth_screens/login_page.dart';
import 'package:simpleApi/screens/notes_screens/add_note.dart';


class AppointHomePage extends StatelessWidget {
  // bool _appointmentTaken = false;

  _showToastMessage(String message) {
    return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteP = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('API Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              _showToastMessage("See you later");
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('username');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: Container(child: Text('Welcome!')),
      // ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: noteP.note.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(
      //       title: Text(
      //         noteP.note[index].body,
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       ),
      //       subtitle: Text(
      //         noteP.note[index].title,
      //         style: TextStyle(fontSize: 15, color: Colors.black),
      //       ),
      //       trailing: IconButton(
      //           icon: Icon(Icons.delete, color: Colors.red),
      //           onPressed: () {
      //             // appointP.deleteAppoint(appointP.appointment[index]);
      //           }),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => AddAppointScreen()));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
      ),
    );
  }

  Future<Null> getData() async {
    var url = "http://192.168.1.23:7070/api/v2/token";
    http.post(url, body: {
      "username": "string",
      "password": "string",
    }).then((response) {
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
    });
  }
}
