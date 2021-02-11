import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:simpleApi/components/colors.dart';

class UserProfileEditScreen extends StatefulWidget {
  @override
  _UserProfileEditScreenState createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  bool showPassword = false;
  String stringResponse;
  List listResponse;
  Map mapResponse;

  // to get the details of individual users
  Future fetchUser() async {
    final url = "http://10.0.2.2:8000/properties/";
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Token 86400c0ca1cc03e34fbfa3bc3a6fc3ca6ed91b1f'
      },
    );
    if (response.statusCode == 200) {
      // var data = FetchUser.fromJson(jsonDecode(response.body));
      // var data = json.decode(response.body) as List;
      // _user = data.map<FetchUser>((json) => FetchUser.fromJson(json)).toList();
      // notifyListeners();
      setState(() {
        mapResponse = json.decode(response.body);

        // listResponse = mapResponse['username'];
      });
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final userProvider = Provider.of<AppointmentProvider>(context);
    print(mapResponse.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.grey[700],
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: mapResponse == null
          ? Center(
              child: Container(
                  width: size.width * 0.5,
                  child: SvgPicture.asset(
                    'assets/404_error.svg',
                    fit: BoxFit.contain,
                  )),
            )
          : Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                    ))),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.green,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print('Edit Button Tapped!');
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    buildTextField("First Name", "Dor Alex", false),
                    buildTextField("Last Name", "Dor Alex", false),
                    buildTextField("Email", "demo@gmail.com", false),
                    buildTextField("Mobile", "9872122234", false),
                    buildTextField("Address", "Kathmandu", false),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          color: buttonColor,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

// Building required text fields
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
                color: buttonColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
