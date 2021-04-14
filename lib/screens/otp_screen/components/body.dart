import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:DentalHome/components/constants.dart';
import 'package:DentalHome/components/providers.dart';
import 'package:DentalHome/screens/auth_screens/register_page.dart';


// Main body of otp screen
class OtpBody extends StatelessWidget {
  final valPhone;

  const OtpBody({Key key, this.valPhone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mobileNotify = Provider.of<Providers>(context);
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text('Verification',
                  style: TextStyle(
                      color: buttonColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2)),
              SizedBox(height: 32.0),
              Text('We have sent OTP code via SMS to ',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.2)),
              SizedBox(height: 15.0),
              timer(),
              SizedBox(height: 45.0),
              OtpFields(valPhone: valPhone),
            ],
          ),
        ),
      ),
    );
  }

// For otp validation timer
  Row timer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('The token will expire in '),
        TweenAnimationBuilder(
            tween: Tween(begin: 300.0, end: 0),
            duration: Duration(seconds: 300),
            builder: (context, value, child) => Text(
                  "${value.toInt()}",
                  style: TextStyle(color: Colors.redAccent),
                )),
        Text(' seconds.')
      ],
    );
  }
}

// Creating otp input fields
class OtpFields extends StatefulWidget {
  final valPhone;

  const OtpFields({Key key, this.valPhone}) : super(key: key);
  @override
  _OtpFieldsState createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  final pin1Controller = TextEditingController();
  final pin2Controller = TextEditingController();
  final pin3Controller = TextEditingController();
  final pin4Controller = TextEditingController();
  final pin5Controller = TextEditingController();
  final pin6Controller = TextEditingController();

  FocusNode pin2;
  FocusNode pin3;
  FocusNode pin4;
  FocusNode pin5;
  FocusNode pin6;

  String userInputOtp;

  @override
  void initState() {
    super.initState();
    pin2 = FocusNode();
    pin3 = FocusNode();
    pin4 = FocusNode();
    pin5 = FocusNode();
    pin6 = FocusNode();
  }

  @override
  void dispose() {
    pin2.dispose();
    pin3.dispose();
    pin4.dispose();
    pin5.dispose();
    pin6.dispose();
    super.dispose();
  }

  // to move to next otp text field
  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpVerifyProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    final mobileNotify = Provider.of<Providers>(context);
    // final userProvider = Provider.of<AppointmentProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SizedBox(
                width: 42.0,
                child: TextFormField(
                    controller: pin1Controller,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    // maxLength: 1,
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (val) {
                      nextField(value: val, focusNode: pin2);
                    }),
              ),
            ),
            SizedBox(
              width: 42.0,
              child: TextFormField(
                  controller: pin2Controller,
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  focusNode: pin2,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (val) {
                    nextField(value: val, focusNode: pin3);
                  }),
            ),
            SizedBox(
              width: 42.0,
              child: TextFormField(
                  controller: pin3Controller,
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  focusNode: pin3,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (val) {
                    nextField(value: val, focusNode: pin4);
                  }),
            ),
            SizedBox(
              width: 42.0,
              child: TextFormField(
                  controller: pin4Controller,
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  focusNode: pin4,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (val) {
                    nextField(value: val, focusNode: pin5);
                  }),
            ),
            SizedBox(
              width: 42.0,
              child: TextFormField(
                  controller: pin5Controller,
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  focusNode: pin5,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (val) {
                    nextField(value: val, focusNode: pin6);
                  }),
            ),
            SizedBox(
              width: 42.0,
              child: TextFormField(
                  controller: pin6Controller,
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  focusNode: pin6,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (val) {
                    pin6.unfocus();
                  }),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.20),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          child: RaisedButton(
            onPressed: () {
              userInputOtp = pin1Controller.text +
                  pin2Controller.text +
                  pin3Controller.text +
                  pin4Controller.text +
                  pin5Controller.text +
                  pin6Controller.text;
              userInputOtp.toString();
              print('User given OTP is: $userInputOtp');
              print(widget.valPhone);
              // Sending OTP for verification
              otpVerifyProvider.verifyOtp(widget.valPhone, userInputOtp);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text('Continue',
                style: TextStyle(
                    color: Colors.white, fontSize: 15.0, letterSpacing: 0.2)),
            color: buttonColor,
          ),
        ),
      ],
    );
  }
}
