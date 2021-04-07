// TO USE API CODES FOR RUNNING APP IN EMULATOR COPY & PASTE FROM API_FOR_EMULATOR.DART AND ALSO REMOVE "S" FROM CLASS NAME

//  ------------------------------------------------------------------->  FOR RUNNING IN MOBILE DEVICES <--------------------------------------------------------//
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/models/dental_services.dart';
import 'package:DentalHome/models/doctors.dart';
import 'package:DentalHome/models/login.dart';
import 'package:DentalHome/models/note.dart';
import 'package:DentalHome/models/signup.dart';
import 'package:DentalHome/models/time_table.dart';
import '../models/appoint.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider with ChangeNotifier {
  AppointmentProvider() {
    fetchAllAppointment();
    fetchAppointment();
    fetchServices();
    fetchTimeTable();
    fetchDoctor();
  }

  // Storing doctors details in list
  List<Doctor> _doctor = [];

  List<Doctor> get doctor {
    return [..._doctor];
  }

  // Storing appoint details in list
  List<Appointment> _appointment = [];

  List<Appointment> get appointment {
    return [..._appointment];
  }

  // Storing appoint details in list
  List<Appointment> _allAppointment = [];

  List<Appointment> get allAppointment {
    return [..._allAppointment];
  }

  // Storing time table
  List<TimeTable> _timeTable = [];

  List<TimeTable> get timeTable {
    return [..._timeTable];
  }

  // Storing user information
  List<FetchUser> _user = [];

  List<FetchUser> get user {
    return [..._user];
  }

  // Storing notes
  List<Note> _note = [];

  List<Note> get note {
    return [..._note];
  }

  // Storing notes
  List<Services> _services = [];

  List<Services> get services {
    return [..._services];
  }

  // Storing user registeration in list
  List<SignUp> _signUp = [];

  List<SignUp> get signUp {
    return [..._signUp];
  }

  // Mobile verify and OTP request
  Future<String> verifyNumber(String mobile) async {
    try {
      final http.Response response =
          await http.post("http://10.0.2.2:8000/verification/",
              headers: <String, String>{
                'Content-type': 'application/json',
              },
              body: jsonEncode(<String, dynamic>{
                'mobile': mobile,
              }));
      if (response.statusCode == 200) {
        print('Phone number verified and code sent');
        notifyListeners();
      } else {
        _showToastMessage(
            'Mobile verification failed! Try again', Colors.redAccent[200]);
        print('Phone verification failed!!');
      }
    } catch (e) {
      print(e);
    }
  }

  // To get mobile devices key and store it for sending fcm
  get_device_key() async {
    final FirebaseMessaging _fcm = FirebaseMessaging();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String device_key;
    _fcm.getToken().then((token) {
      device_key = token;
      print('The device token is:' + device_key);
    });

    final http.Response response = await http.post(
      'http://10.0.2.2:8000/save_device_token/',
      headers: <String, String>{
        'Content-type': 'application/json',
        "Authorization": "Token $token"
      },
      body: jsonEncode(
        <String, dynamic>{
          'device_key': device_key,
        },
      ),
    );
    if (response.statusCode == 200) {
      _showToastMessage('Device key registered 🙌', Colors.teal[300]);
      notifyListeners();
    } else {
      _showToastMessage('Device key failed to save!', Colors.redAccent[200]);
      // print('Otp code registration failed!!');
    }
  }

  // To send fcm notification to the appropriate staff for confirmation
  staff_fcm(int staff_id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      final response = await http.post(
        "http://10.0.2.2:8000/sending_fcm/$staff_id/",
        headers: {
          'Content-type': 'application/json',
          "Authorization": "Token $token"
        },
      );
      if (response.statusCode == 200) {
        _showToastMessage('Booking Requested', Colors.teal[300]);
        notifyListeners();
      } else {
        _showToastMessage('Booking Failed!', Colors.redAccent[200]);
        // print('Otp code registration failed!!');
      }
    } catch (e) {
      print(e);
    }
  }

  // To send fcm notification to the staff after booking has been confirmed
  patient_fcm(int appointment_id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      final response = await http.post(
        "http://10.0.2.2:8000/confirmed_fcm/$appointment_id/",
        headers: {
          'Content-type': 'application/json',
          "Authorization": "Token $token"
        },
      );
      if (response.statusCode == 200) {
        _showToastMessage('Your appointment has been confirmed', Colors.teal[300]);
        notifyListeners();
      } else {
        _showToastMessage('Appointment was rejected!', Colors.redAccent[200]);
        // print('Otp code registration failed!!');
      }
    } catch (e) {
      print(e);
    }
  }

  // Verify recieved OTP code
  Future<String> verifyOtp(String mobile, String otp) async {
    try {
      final response =
          await http.post("http://10.0.2.2:8000/verification/token/",
              headers: {
                'Content-type': 'application/json',
              },
              body: jsonEncode(<String, dynamic>{
                'mobile': mobile,
                'otp': otp,
              }));
      if (response.statusCode == 200) {
        print('Otp code confirmed and registered');
        _showToastMessage('OTP code verified 🙌', Colors.teal[300]);
        notifyListeners();
      } else {
        _showToastMessage(
            'Otp code registration failed!', Colors.redAccent[200]);
        print('Otp code registration failed!!');
      }
    } catch (e) {
      print(e);
    }
  }

  // Change user password
  Future<String> changePassword(
      String old_password, String password, String password2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int pk = prefs.getInt('pk');
    // print(pk);

    final http.Response response =
        await http.put('http://10.0.2.2:8000/change_password/$pk/',
            headers: <String, String>{
              'Content-type': 'application/json',
              // 'Accept': 'ap 2q  /json',
              "Authorization": "Token $token"
            },
            body: jsonEncode(<String, dynamic>{
              'old_password': old_password,
              'password': password,
              'password2': password2,
            }));

    if (response.statusCode == 200) {
      print('Password successfully changed :D');
      _showToastMessage('Password change successful 🔐', Colors.teal[300]);
      notifyListeners();
      return 'success';
    } else {
      _showToastMessage(
          'Failed! Enter correct and strong password', Colors.redAccent[200]);
      return 'failure';
    }
  }

  //to get reset password reset email
  Future<String> getResetEmail(String email) async {
    final http.Response response =
        await http.post('http://10.0.2.2:8000/reset_email/',
            headers: <String, String>{
              'Content-type': 'application/json',
              // 'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              'email': email,
            }));

    if (response.statusCode == 200) {
      print('Reset email has been sent to the specific user :)');
      notifyListeners();
      return 'success';
    } else {
      _showToastMessage('Error! Email sent failed', Colors.redAccent[200]);
      return 'failure';
    }
  }

  //to get reset password reset email
  Future<String> passwordResetConfirmation(
      String password, String token, String uid) async {
    final http.Response response =
        await http.patch('http://10.0.2.2:8000/password_reset_compelete/',
            headers: <String, String>{
              'Content-type': 'application/json',
              // 'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              'password': password,
              'token': token,
              'uidb64': uid,
            }));

    if (response.statusCode == 200) {
      print('Password reset successful :)');
      notifyListeners();
      return 'success';
    } else {
      _showToastMessage('Password reset failed', Colors.redAccent[200]);
      return 'failure';
    }
  }

  // to register a new user
  void signup(SignUp signUp) async {
    final response = await http.post("http://10.0.2.2:8000/auth/register/",
        headers: {"Content-Type": "multipart/form-data"},
        body: json.encode(signUp));
    if (response.statusCode == 200) {
      signUp.id = json.decode(response.body)['id'];
      _signUp.add(signUp);
      notifyListeners();
    } else {
      _showToastMessage('Registration failed!', Colors.redAccent[200]);
      // throw Exception('User failed to register!');
    }
  }

  // To add appointment
  void addAppointment(String appointmentTime, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final http.Response response =
        await http.post('http://10.0.2.2:8000/appointment/add/$id/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Authorization": "Token $token"
            },
            // body: LoginRequestModel().toJson());
            body: jsonEncode(
              <String, dynamic>{
                'appointmentTime': appointmentTime,
                // 'appointmentBy': doctor,
                // 'username': user,
              },
            ));
    if (response.statusCode == 200) {
      notifyListeners();
      print('success');
    } else {
      print('failure');
      // _showToastMessage('Failed to load data!', Colors.redAccent[200]);
    }
  }

// to get the details of individual users appointment details
  void fetchAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);

    final url = "http://10.0.2.2:8000/appointment/list/?format=json";
    // final url = "http://10.0.2.2:8000/appointment/list/?format=json";
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      print(data);
      _appointment =
          data.map<Appointment>((json) => Appointment.fromJson(json)).toList();
      // fetchAppointment();
      notifyListeners();
    } else {
      _showToastMessage('Failed to load data!', Colors.redAccent[200]);
    }
  }

  // to get all the details of users appointment details
  void fetchAllAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);

    final url = "http://10.0.2.2:8000/appointment/list/?format=json";
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _allAppointment =
          data.map<Appointment>((json) => Appointment.fromJson(json)).toList();
      // fetchAllAppointment();
      notifyListeners();
    } else {
      _showToastMessage('Failed to load data!', Colors.redAccent[200]);
    }
  }

  // to delete or cancel the appointment
  void deleteAppoint(int id) async {
    final response =
        await http.delete("http://10.0.2.2:8000/appointment/list-details/$id/");
    if (response.statusCode == 204) {
      // _appointment.remove(appointment);
      notifyListeners();
    } else {
      _showToastMessage('Failed to delete data!', Colors.redAccent[200]);
      throw Exception('Failed to remove data!');
    }
  }

  // to get the details of individual users appointment details
  void fetchTimeTable() async {
    final url = "http://10.0.2.2:8000/time_table/list/?format=json";
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _timeTable =
          data.map<TimeTable>((json) => TimeTable.fromJson(json)).toList();
      notifyListeners();
    } else {
      _showToastMessage('Failed to load data!', Colors.redAccent[200]);
    }
  }

// to update doctor time table
  Future<String> updateTimeTable(String time_space, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final url = "http://10.0.2.2:8000/time_table/details/$id/";
    final response = await http.patch(url,
        headers: <String, String>{
          'Content-type': 'application/json',
          "Authorization": "Token $token"
        },
        body: jsonEncode(<String, dynamic>{
          'time_space': time_space,
        }));
    if (response.statusCode == 200) {
      _showToastMessage('Time successfully updated', Colors.teal[400]);
      return 'success';
    } else {
      _showToastMessage('Failed to save time', Colors.redAccent[200]);
      return 'failure';
    }
  }

// to add new notes
  void addNote(Note note) async {
    // String token = await Candidate().getToken();
    final response = await http.post("http://10.0.2.2:8000/api/note/create/",
        headers: {
          "Content-Type": "application/json",
          // 'Authorization': 'Bearer $token',
        },
        body: json.encode(note));
    if (response.statusCode == 201) {
      note.id = json.decode(response.body)['id'];
      _note.add(note);
      notifyListeners();
    } else {
      throw Exception('Failed to add appointment!');
    }
  }

// to get the details of individual users notes details
  fetchNote(LoginRequestModel loginRequestModel, Note note) async {
    final url = "http://10.0.2.2:8000/api/note/list/?format=json";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _note = data.map<Note>((json) => Note.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // to delete or cancel the appointment
  void deleteNote(Note note) async {
    final response = await http.delete("http://10.0.2.2:8000/api/note/");
    if (response.statusCode == 204) {
      _note.remove(note);
      notifyListeners();
    } else {
      throw Exception('Failed to remove data!');
    }
  }

// to get the details of individual users notes details
  void fetchDoctor() async {
    final url = "http://10.0.2.2:8000/doctor/list/?format=json";
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _doctor = data.map<Doctor>((json) => Doctor.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load doctor data!');
    }
  }

  // to get the details of individual users appointment details
  void fetchServices() async {
    final url = "http://10.0.2.2:8000/service/list/?format=json";
    // final url = "http://10.0.2.2:8000/service/list/?format=json";
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _services =
          data.map<Services>((json) => Services.fromJson(json)).toList();
      print('Services count is: -');
      print(services.length);
      notifyListeners();
    } else {
      _showToastMessage('Failed to load services data!', Colors.redAccent[200]);
    }
  }

  Future<String> updateUserProfile(
      String first_name, last_name, email, address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);

    final url = "http://10.0.2.2:8000/properties/update/";
    final response = await http.put(url,
        headers: <String, String>{
          // "Content-Type": "application/json",
          'Content-type': 'application/json',
          // 'Accept': 'ap 2q  /json',
          "Authorization": "Token $token"
        },
        body: jsonEncode(<String, dynamic>{
          // 'username': username,
          'first_name': first_name,
          'last_name': last_name,
          'email': email,
          'address': address,
        }));
    if (response.statusCode == 200) {
      print('Profile Updated :D');
      _showToastMessage('Update Successful', Colors.teal[300]);
      notifyListeners();
      return 'success';
    } else {
      print(response.body);
      _showToastMessage('Failed to update user data!', Colors.redAccent[200]);
      return 'failure';
    }
  }

  // To show appropriate toast message
  _showToastMessage(String message, Color color) {
    return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
