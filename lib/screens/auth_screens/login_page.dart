import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/models/credential.dart';
import 'package:simpleApi/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:simpleApi/screens/app_screens/main_menu_page.dart';
import 'package:simpleApi/screens/auth_screens/register_page.dart';
// import 'package:simpleApi/shared_preference/shared_pref.dart';

import '../../ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String token_received_from_auth;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // SharedPref sharedPref = SharedPref();
  // Credential userSave = Credential();
  // bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

// To show appropriate toast message
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

  Widget _uiSetup(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/circular.PNG",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          // backgroundColor: Theme.of(context).accentColor,
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          // margin:
                          //     EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.vertical(
                          //       bottom: Radius.circular(200)),
                          //   color: primaryColor,
                          //   image: DecorationImage(
                          //       image: AssetImage('assets/circular.png')),
                          //   // boxShadow: [
                          //   //   BoxShadow(
                          //   //       color:
                          //   //           Theme.of(context).hintColor.withOpacity(0.2),
                          //   //       offset: Offset(0, 10),
                          //   //       blurRadius: 20)
                          //   // ],
                          // ),
                          child: Form(
                            key: globalFormKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                SvgPicture.asset(
                                  "assets/logo.svg",
                                  fit: BoxFit.contain,
                                  height: 80.0,
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  "Dental Home",
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 25.0),
                                ),
                                SizedBox(height: 40),
                                // Text(
                                //   "Login Credentials",
                                //   style: TextStyle(
                                //       fontSize: 15,
                                //       color: Colors.grey[800],
                                //       fontWeight: FontWeight.w400),
                                // ),
                                SizedBox(height: 20),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: new TextFormField(
                                    style: TextStyle(color: Colors.grey[800]),
                                    controller: usernameController,
                                    onSaved: (input) =>
                                        loginRequestModel.username = input,
                                    validator: (input) => input.length < 1
                                        ? "Username should be valid"
                                        : null,
                                    decoration: new InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 11.0),
                                      fillColor: Colors.white,
                                      hintText: "Username",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: primaryColor,
                                      )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.black87,
                                      )),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: new TextFormField(
                                    style: TextStyle(color: Colors.grey[800]),
                                    keyboardType: TextInputType.text,
                                    controller: passwordController,
                                    onSaved: (input) =>
                                        loginRequestModel.password = input,
                                    validator: (input) => input.length < 3
                                        ? "Enter a valid password"
                                        : null,
                                    obscureText: hidePassword,
                                    decoration: new InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 11.0),
                                      fillColor: Colors.white,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: primaryColor,
                                      )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87)),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.grey[700],
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = !hidePassword;
                                          });
                                        },
                                        color: Colors.grey[700],
                                        icon: Icon(hidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 43.0,
                                  child: FlatButton(
                                    // padding: EdgeInsets.symmetric(
                                    //     vertical: 12.0, horizontal: 150.0),
                                    onPressed: () {
                                      loginUser(usernameController.text,
                                          passwordController.text);
                                      if (validateAndSave()) {
                                        print(loginRequestModel.toJson());

                                        setState(() {
                                          isApiCallProcess = true;
                                          this.usernameController.text = '';
                                          this.passwordController.text = '';
                                        });
                                        // signIn(usernameController.text, passwordController.text);
                                        // loginUser(usernameController.text,
                                        //     passwordController.text);
                                        // APIService apiService = new APIService();
                                        // apiService
                                        // login(loginRequestModel).then((value) async {
                                        //   if (value != null) {
                                        //     setState(() {
                                        //       isApiCallProcess = false;
                                        //     });

                                        //     if (value.token.isNotEmpty) {
                                        //       final snackBar = SnackBar(
                                        //           content: Text("Login Successful"));
                                        //       scaffoldKey.currentState
                                        //           .showSnackBar(snackBar);
                                        //       final SharedPreferences
                                        //           sharedPreferences =
                                        //           await SharedPreferences
                                        //               .getInstance();
                                        //       sharedPreferences.setString('username',
                                        //           usernameController.text);
                                        //       _showToastMessage("Login Successful");
                                        //       Navigator.push(
                                        //           context,
                                        //           MaterialPageRoute(
                                        //               builder: (context) =>
                                        //                   AppointHomePage()));
                                        //     } else {
                                        //       _showToastMessage("Login failed!");
                                        //       // final snackBar = SnackBar(
                                        //       //     content: Text(value.error));
                                        //       // scaffoldKey.currentState
                                        //       //     .showSnackBar(snackBar);
                                        //     }
                                        //   }
                                        // });
                                      }
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          color: buttonTextColor,
                                          fontSize: 15.0),
                                    ),
                                    color: primaryColor,
                                    // shape: StadiumBorder(),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not Registered?",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            " Sign Up",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

// To validate the text fields before saving
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

// Login connection with API for authenticating the user
  Future<String> loginUser(String username, String password) async {
    final http.Response response =
        await http.post('http://10.0.2.2:8000/auth/login/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            // body: LoginRequestModel().toJson());
            body: jsonEncode(
              <String, dynamic>{
                'username': username,
                'password': password,
              },
            ));
    if (response.statusCode == 200) {
      print(response);
      String token = jsonDecode(response.body)['token'].toString();
      print(token);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', token);
      checkLogin(token);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MainMenu()));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainMenu()),
          (Route<dynamic> route) => false);
      return token;
    } else {
      _showToastMessage('Login failed!');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      // throw Exception('Failed to load!');
    }
  }

  // var received_token;

  // void getToken() async {
  //   String userToken =
  //       await loginUser(usernameController.text, passwordController.text);
  //   setState(() {
  //     received_token = userToken;
  //   });
  // }

  // Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
  //   String url = "http://10.0.2.2:8000/auth/login/";

  //   final response = await http.post(url, body: requestModel.toJson());
  //   if (response.statusCode == 200 || response.statusCode == 400) {
  //     print(response);
  //     String token = jsonDecode(response.body)['token'].toString();
  //     print(token);
  //     return LoginResponseModel.fromJson(json.decode(response.body));
  //   }
  //   else {
  //     throw Exception('Failed to load data!');
  //   }
  // }

  // loginUser(String username, password) async {
  //       Map data = {
  //     'username': username,
  //     'password': password
  //   };
  //   final response =
  //       await http.post('http://10.0.2.2:8000/api/login/',
  //           // headers: <String, String>{
  //           //   'Content-Type': 'application/json; charset=UTF-8',
  //           // },
  //           body: data);
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
  //   String userToken =
  //       await loginUser(usernameController.text, passwordController.text);
  //   setState(() {
  //     token_received_from_auth = userToken;
  //   });
  // }

  // signIn(String username, String pass) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map data = {'username': username, 'password': pass};
  //   var jsonResponse = null;
  //   var response =
  //       await http.post("http://10.0.2.2:8000/app/login/", body: data);
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     checkLogin(jsonResponse['token']);
  //     print(jsonResponse);
  //     if (jsonResponse != null) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       sharedPreferences.setString("token", jsonResponse['data']['token']);
  //       userSave.token = jsonResponse['token'];
  //       userSave.username = jsonResponse['username'];
  //       sharedPref.save("user", userSave);
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => AppointHomePage()),
  //           (Route<dynamic> route) => false);
  //     }
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // errorMsg = response.body;
  //     print("The error message is: ${response.body}");
  //     Fluttertoast.showToast(
  //       msg: "Invalid username or password",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red[400],
  //       textColor: Colors.white,
  //       fontSize: 14.0,
  //     );
  //   }
  // }

  Future checkLogin(String token) async {
    if (token != null) {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple[400],
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Invalid username or password!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[300],
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
