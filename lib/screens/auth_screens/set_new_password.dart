import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:DentalHome/components/colors.dart';

class SetNewPasswordScreen extends StatefulWidget {
  @override
  _SetNewPasswordScreenState createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController tokenController = new TextEditingController();
  final TextEditingController uidController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 20.0),
                      Text(
                        'Set new password',
                        style: TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: SvgPicture.asset('assets/pwd_icon1.svg')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Enter your new password along with the token and id that has been provided to you via email.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.grey[800],
                          // letterSpacing: 0.2,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 27.0),
                    _textField(passwordController, 'Enter a valid password *',
                        'New Password', Icon(Icons.lock, color: Colors.teal)),
                    SizedBox(height: 15.0),
                    _textField(
                        passwordController,
                        'Enter a valid password *',
                        'Confirmation Token',
                        Icon(Icons.code, color: Colors.teal)),
                    SizedBox(height: 15.0),
                    _textField(passwordController, 'Enter a valid password *',
                        'Uid', Icon(Icons.file_present, color: Colors.teal)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        tooltip: 'Increment Counter',
        child: const Icon(Icons.send),
      ),
    );
  }

  // Text field creation
  _textField(TextEditingController controller, String validator,
      String hintText, Icon icon) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        style: TextStyle(color: Colors.grey[800]),
        keyboardType: TextInputType.text,
        controller: controller,
        validator: (input) => input.length < 3 ? "$validator" : null,
        decoration: new InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 11.0),
          hintText: "$hintText",
          hintStyle: TextStyle(color: Colors.grey[800]),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: primaryColor,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black87,
          )),
          prefixIcon: icon,
        ),
      ),
    );
  }
}
