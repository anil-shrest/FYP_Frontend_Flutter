import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simpleApi/api/auth_service.dart';
// import 'package:simpleApi/models/credential.dart';
import 'package:simpleApi/models/login.dart';
import 'package:simpleApi/models/note.dart';
import 'package:simpleApi/models/signup.dart';
// import 'package:simpleApi/screens/loginPage.dart';
// import 'package:simpleApi/shared_preference/shared_pref.dart';
import '../models/appoint.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider with ChangeNotifier {
  // SharedPref sharedPref = SharedPref();
  // Credential userSave = Credential();
  // bool _isLoading = false;

  // AppointmentProvider() {
  //   // this.fetchTask();
  // }

// Storing appoint details in list
  List<Appointment> _appointment = [];

  List<Appointment> get appointment {
    return [..._appointment];
  }

  // Storing notes
  List<Note> _note = [];

  List<Note> get note {
    return [..._note];
  }

  // Storing user registeration in list
  List<SignUp> _signUp = [];

  List<SignUp> get signUp {
    return [..._signUp];
  }

  // var authInfo;
  
  void addAppoint(Appointment appointment) async {
    var token = '86400c0ca1cc03e34fbfa3bc3a6fc3ca6ed91b1f';
    final response = await http.post("http://10.0.2.2:8000/appointment/list/",
        // headers: {'Authorization': 'Token $token'},
        body: json.encode(appointment));
    if (response.statusCode == 201) {
      appointment.id = json.decode(response.body)['id'];
      _appointment.add(appointment);
      notifyListeners();
    } else {
      throw Exception('Failed to add appointment!');
    }
  }

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

  void signup(SignUp signUp) async {
    final response = await http.post("http://10.0.2.2:8000/auth/register/",
        // headers: {"Content-Type": "multipart/form-data"},
        body: json.encode(signUp));
    if (response.statusCode == 200) {
      signUp.id = json.decode(response.body)['id'];
      _signUp.add(signUp);
      notifyListeners();
    } else {
      throw Exception('User failed to register!');
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

  fetchTask() async {
    final url = "http://10.0.2.2:8000/app/?format=json";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _appointment =
          data.map<Appointment>((json) => Appointment.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data!');
    }
    // notifyListeners();
  }

  fetchNote(LoginRequestModel loginRequestModel, Note note) async {
    final url =
        "http://10.0.2.2:8000/api/note/${loginRequestModel.username}-${note.title}/?format=json";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _note = data.map<Note>((json) => Note.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data!');
    }
    // notifyListeners();
  }

  void deleteAppoint(Appointment appointment) async {
    final response =
        await http.delete("http://10.0.2.2:8000/api/${appointment.id}/");
    // await http.delete("http://10.0.2.2:8000/app/");
    if (response.statusCode == 204) {
      _appointment.remove(appointment);
      notifyListeners();
    } else {
      throw Exception('Failed to remove data!');
    }
  }

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
