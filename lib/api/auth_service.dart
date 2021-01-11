// import 'package:flutter_session/flutter_session.dart';
// import 'package:http/http.dart' as http;

// class AuthService {
//   static final SESSION = FlutterSession();
//   final baseUrl = "http://10.0.2.2:8000/app/register/";

//   Future<dynamic> register(
//       String email, String username, String password) async {
//     try {
//       var res = await http.post('$baseUrl', body: {
//         'email': email,
//         'username': username,
//         'password': password,
//       });
//       return res?.body;
//     } finally {}
//   }

//   static setToken(String token, String refreshToken) async {
//     _AuthData data = _AuthData(token, refreshToken);
//     await SESSION.set('tokens', data);
//   }

//   static Future<Map<String, dynamic>> getToken() async {
//     return await SESSION.get('tokens');
//   }

//   static removeToken() async {
//     await SESSION.prefs.clear();
//   }
// }

// class _AuthData {
//   String token, refreshToken, clientId;
//   _AuthData(this.token, this.refreshToken, {this.clientId});

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();

//     data['token'] = token;
//     data['refreshToken'] = refreshToken;
//     data['clientId'] = clientId;
//     return data;
//   }
// }
