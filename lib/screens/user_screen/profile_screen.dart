import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:DentalHome/screens/user_screen/profile_edit_screen.dart';
import 'user_settings.dart';

// User Profile UI creation with data
class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool showPassword = false;
  // String stringResponse;
  // List listResponse;
  Map mapResponse;

  // to get the details of individual users
  Future fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final url = "http://10.0.2.2:8000/properties/";
    final response = await http.get(
      url,
      headers: {
        'Authorization': "Token $token",
      },
    );
    if (response.statusCode == 200) {
      // var data = FetchUser.fromJson(jsonDecode(response.body));
      // var data = json.decode(response.body) as List;
      // _user = data.map<FetchUser>((json) => FetchUser.fromJson(json)).toList();
      // notifyListeners();
      setState(() {
        mapResponse = json.decode(response.body);
        print(mapResponse['id']);
      });
      // Saving user primary key
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt('pk', mapResponse['id']);
      print('pk is');
      print(mapResponse['id']);
      // print(mapResponse['is_staff']);
      // for (var i = 0; i < mapResponse.length; i++)
      //   print(mapResponse[i.toString()]);
    } else {
      // throw Exception('Failed to load data!');
      print('No INTERNET');
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
    // String imageName = mapResponse['profile_image'].toString();
    // print('Image is -->' + imageName);
    // print(mapResponse.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSetting()));
            },
          )
        ],
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
                                image: mapResponse['profile_image'] == null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/UserLogo.png",
                                        ))
                                    : DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                          "http://10.0.2.2:8000" +
                                              mapResponse['profile_image']
                                                  .toString(),
                                        )),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    buildTextField("First Name",
                        mapResponse['first_name'].toString(), false),
                    buildTextField("Last Name",
                        mapResponse['last_name'].toString(), false),
                    buildTextField(
                        "Email", mapResponse['email'].toString(), false),
                    buildTextField(
                        "Mobile", mapResponse['mobile'].toString(), false),
                    buildTextField(
                        "Address", mapResponse['address'].toString(), false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Color(0xFF2cd1a8),
                            child: InkWell(
                              splashColor: buttonColor,
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfileEditScreen()));
                              },
                            ),
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
        enabled: false,
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
