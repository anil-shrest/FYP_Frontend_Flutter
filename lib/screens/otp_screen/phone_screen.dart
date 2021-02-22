import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/screens/otp_screen/otp_verification.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  String mobile_numb;

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpCodeProvider = Provider.of<AppointmentProvider>(context);
    final mobileNotify = Provider.of<Providers>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Mobile Number',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2)),
              SizedBox(height: 40.0),
              Text(
                  'A SMS with 6 digit code for OTP verfication will be sent to this number.',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.2)),
              SizedBox(height: 20.0),
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                controller: mobileController,
                validator: (text) {
                  if (text == null || text.isEmpty || text.length <= 9) {
                    return 'Number should contain 10 digits!';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.grey[800]),
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  // errorText: validateNumber(mobileController.text),
                  contentPadding: const EdgeInsets.symmetric(vertical: 11.0),
                  hintText: "Mobile Number",
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: primaryColor,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black87,
                  )),
                  prefixIcon: Icon(Icons.phone_android, color: buttonColor),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    mobile_numb = (mobileController.text);
                    if (_formKey.currentState.validate()) {
                      mobileNotify.setMobileNumber('+977$mobile_numb');
                      print(mobileNotify.mobileNumber);
                      print(mobileController.text);
                      // Sending otp code via sms
                      otpCodeProvider.verifyNumber(mobileNotify.mobileNumber);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OtpScreen(valPhone: mobileController.text)));
                    }
                  },
                  child: Text('Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          letterSpacing: 0.2)),
                  color: buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateNumber(String value) {
    if (!(value.length < 9) && value.isNotEmpty) {
      return "Number should contain 10 digits!";
    }
    return null;
  }
}
