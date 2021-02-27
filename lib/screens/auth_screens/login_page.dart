import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:simpleApi/screens/app_screens/main_menu_page.dart';
import 'package:simpleApi/screens/auth_screens/register_page.dart';

import '../../ProgressHUD.dart';

//  Login page creation
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
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
      backgroundColor: Colors.teal[300],
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
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
                                    onPressed: () {
                                      loginUser(usernameController.text,
                                          passwordController.text);
                                      if (validateAndSave()) {
                                        print(loginRequestModel.toJson());
                                      }
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          color: buttonTextColor,
                                          letterSpacing: 0.3,
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
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: Container(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.deepOrange, letterSpacing: 0.2),
                        ),
                      ),
                    ),
                    Divider(color: Colors.black, indent: 80.0, endIndent: 80.0),
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
                                letterSpacing: 0.2),
                          ),
                          Text(
                            " Sign Up",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                letterSpacing: 0.2),
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

  //  Pop up dialog box to get email from user to reset password
  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: _SystemPadding(
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              new Expanded(
                  child: Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Enter email to get password reset url',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17.0),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (input) => input.length < 3 || input.isEmpty
                            ? "Enter proper credential*"
                            : null,
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11.0),
                          hintText: "Email Address",
                          // hintStyle: TextStyle(color: Colors.grey[800]),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: primaryColor,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey[700],
                          )),
                          focusColor: Colors.tealAccent,
                          prefixIcon: Icon(Icons.mail, color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: Text('Cancel',
                    style: TextStyle(color: Colors.red[300], fontSize: 15.0)),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
              child: Text('Confirm',
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print(emailController.text);
                  _showToastMessage('Reset url has been sent to the mail');
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
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
      String tokenVal = preferences.getString('token');
      checkLogin(tokenVal);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MainMenu()));
      if (token != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainMenu()),
            (Route<dynamic> route) => false);
      } else {
        checkLogin(token);
      }
      return token;
    } else {
      _showToastMessage("Invalid Credentials");
    }
  }

  Future checkLogin(String token) async {
    if (token != null) {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
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

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
