import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool hidePassword = true;
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final oldPwdController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pwdChangeProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: globalFormKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              _passwordTextField(
                  oldPwdController,
                  'Do not leave this field empty *',
                  'Old Password ',
                  Icon(
                    Icons.lock_open,
                    color: Colors.teal,
                  )),
              SizedBox(height: 20),
              _passwordTextField(
                  passwordController,
                  'Do not leave this field empty *',
                  'New Password',
                  Icon(
                    Icons.lock,
                    color: Colors.teal,
                  )),
              SizedBox(height: 20),
              _passwordTextField(
                  password2Controller,
                  'Do not leave this field empty *',
                  'Confirm New Password',
                  Icon(
                    Icons.lock_clock,
                    color: Colors.teal,
                  )),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 43.0,
                child: FlatButton(
                  onPressed: () async {
                    // print(oldPwdController.text);
                    // print(passwordController.text);
                    // print(password2Controller.text);
                    if (validateAndSave()) {
                      pwdChangeProvider.changePassword(oldPwdController.text,
                          passwordController.text, password2Controller.text);

                      // passwordController.text = '';
                      // password2Controller.text = '';
                      // oldPwdController.text = '';
                    } else {
                      print('ERROR!!!');
                    }

                    // print(pwdChangeProvider.changePassword);
                    // loginUser(usernameController.text, passwordController.text);
                    // if (validateAndSave()) {
                    //   print(loginRequestModel.toJson());

                    //   setState(() {
                    //     isApiCallProcess = true;
                    //     this.usernameController.text = '';
                    //     this.passwordController.text = '';
                    //   });
                    // }
                  },
                  child: Text(
                    "Save Password",
                    style: TextStyle(color: buttonTextColor, fontSize: 15.0),
                  ),
                  color: primaryColor,
                  // shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Password field creation
  _passwordTextField(TextEditingController controller, String validator,
      String hintText, Icon icon) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: new TextFormField(
        // style: TextStyle(color: Colors.grey[800]),
        keyboardType: TextInputType.text,
        controller: controller,
        validator: (input) => input.length < 3 ? "$validator" : null,
        obscureText: hidePassword,
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 11.0),
          fillColor: Colors.white,
          hintText: "$hintText",
          // hintStyle: TextStyle(color: Colors.grey[800]),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: primaryColor,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black87,
          )),
          prefixIcon: icon,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            // color: Colors.grey[700],
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }

// Validating text fields before saving
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
