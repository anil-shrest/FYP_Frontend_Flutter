import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/models/dental_services.dart';
import 'package:simpleApi/models/doctors.dart';
import 'package:simpleApi/models/login.dart';
import 'package:simpleApi/models/note.dart';
import 'package:simpleApi/models/signup.dart';
import 'package:simpleApi/models/time_table.dart';
import '../models/appoint.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider with ChangeNotifier {
  // SharedPref sharedPref = SharedPref();
  // Credential userSave = Credential();
  // bool _isLoading = false;

  AppointmentProvider() {
    // fetchAppointment();
    // fetchServices();
    // fetchTimeTable();
    // fetchDoctor();
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

  // Future<String> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   return token;
  // }

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
      String old_password, password, password2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int pk = prefs.getInt('pk');

    final http.Response response =
        await http.put('http://10.0.2.2:8000/change_password/$pk/',
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
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

// // to get the details of individual users
//   Future fetchUser() async {
//     final url = "http://10.0.2.2:8000/properties/?format=json";
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Token 86400c0ca1cc03e34fbfa3bc3a6fc3ca6ed91b1f'
//       },
//     );
//     if (response.statusCode == 200) {
//       // var data = FetchUser.fromJson(jsonDecode(response.body));
//       // var data = json.decode(response.body) as List;
//       // _user = data.map<FetchUser>((json) => FetchUser.fromJson(json)).toList();
//       // notifyListeners();
//       set
//     } else {
//       throw Exception('Failed to load data!');
//     }
//   }

  // void getAppoint(Appointment appointment) async {
  //   var token = '86400c0ca1cc03e34fbfa3bc3a6fc3ca6ed91b1f';
  //   final response = await http.get(
  //     "http://10.0.2.2:8000/appointment/list/?format=json",
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       "Authorization": "Bearer $token"
  //     },
  //     body: json.encode(appointment)
  //   );
  //   if (response.statusCode == 201) {
  //     appointment.id = json.decode(response.body)['id'];
  //     _appointment.add(appointment);
  //     notifyListeners();
  //   } else {
  //     throw Exception('Failed to add appointment!');
  //   }
  // }

  //to get reset password reset email
  Future<String> getResetEmail(String email) async {
    final http.Response response =
        await http.post('http://10.0.2.2:8000/reset_email/',
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
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

  // Future<SignUp> signup(String first_name, String last_name, String mobile, String email,
  //     String username, String password, String password2) async {
  //   final http.Response response = await http.post(
  //       "http://10.0.2.2:8000/auth/register/",
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8'
  //       },
  //       body: json.encode(signUp));
  //   if (response.statusCode == 200) {
  //     notifyListeners();
  //     return SignUp.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to register');
  //   }
  // }

// to add new appointment
  void addAppoint(Appointment appointment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final response = await http.post("http://10.0.2.2:8000/appointment/list/",
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: json.encode(appointment));
    if (response.statusCode == 201) {
      appointment.id = json.decode(response.body)['id'];
      _appointment.add(appointment);
      notifyListeners();
    } else {
      _showToastMessage('Failed to add appointment!', Colors.redAccent[200]);
    }
  }

  // to add new appointment
  void addAppointment(Appointment appointment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final response = await http.post("http://10.0.2.2:8000/appointment/list/",
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: json.encode(appointment));
    if (response.statusCode == 201) {
      appointment.id = json.decode(response.body)['id'];
      _appointment.add(appointment);
      notifyListeners();
    } else {
      _showToastMessage('Failed to add appointment!', Colors.redAccent[200]);
    }
  }

// to get the details of individual users appointment details
  void fetchAppointment() async {
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
      _appointment =
          data.map<Appointment>((json) => Appointment.fromJson(json)).toList();
      notifyListeners();
    } else {
      _showToastMessage('Failed to load data!', Colors.redAccent[200]);
    }
  }

  // to get the details of individual users appointment details
  void fetchTimeTable() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    // print(token);

    final url = "http://10.0.2.2:8000/time_table/list/?format=json";
    final response = await http.get(
      url,
      // headers: {'Authorization': 'Token $token'},
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

  // to delete or cancel the appointment
  void deleteAppoint(Appointment appointment) async {
    final response =
        await http.delete("http://10.0.2.2:8000/appointment/list/");
    if (response.statusCode == 204) {
      _appointment.remove(appointment);
      notifyListeners();
    } else {
      throw Exception('Failed to remove data!');
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    // print(token);

    final url = "http://10.0.2.2:8000/doctor/list/?format=json";
    final response = await http.get(
      url,
      // headers: {'Authorization': 'Token $token'},
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    // print(token);

    final url = "http://10.0.2.2:8000/service/list/?format=json";
    final response = await http.get(
      url,
      // headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _services =
          data.map<Services>((json) => Services.fromJson(json)).toList();
      // Saving service id
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // sharedPreferences.setInt('id', id);
      print('Services count is: -');
      print(services.length);
      notifyListeners();
    } else {
      _showToastMessage('Failed to load services data!', Colors.redAccent[200]);
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

  // http://127.0.0.1:8000/service/list/?format=json <------ TO GET SERVCIES JSON

  // void verifyToken(String token) {
  //   var url = "<url to backend api>";
  //   var client = http.Client();
  //   var request = http.Request('POST', Uri.parse(url));
  //   var body = {'id_token': token};
  //   request.bodyFields = body;
  //   var future = client.send(request).then((response) {
  //     response.stream.bytesToString().then((value) {
  //       print(value.toString());
  //     }).catchError((error) {
  //       print(error.toString());
  //     });
  //   });
  // }
}

// class APIService {
//   Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
//     String url = "http://10.0.2.2:8000/app/login/";

//     final response = await http.post(url, body: requestModel.toJson());
//     if (response.statusCode == 200 || response.statusCode == 400) {
//       print(response);
//       String token = jsonDecode(response.body)['token'].toString();
//       print(token);
//       return LoginResponseModel.fromJson(json.decode(response.body));
//     }
//     // else {
//     //   throw Exception('Failed to load data!');
//     // }
//   }

// Future<String> loginUser(String username, String password) async {
//   final http.Response response =
//       await http.post('http://10.0.2.2:8000/app/login/',
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: LoginRequestModel().toJson());
//   if (response.statusCode == 200) {
//     print(response);
//     String token = jsonDecode(response.body)['token'].toString();
//     print(token);
//     return token;
//   } else {
//     throw Exception('Failed to load!');
//   }
// }

// void getToken() async {
//   String userToken = await loginUser(username, password)
// }
