import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:DentalHome/components/colors.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final url = "http://10.0.2.2:8000/properties/";
    final response = await http.get(
      url,
      headers: {'Authorization': 'Token $token'},
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
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // elevation: 1,
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
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "http://10.0.2.2:8000" +
                                            mapResponse['profile_image']
                                                .toString(),
                                      )),
                            ),
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
                    buildTextField("First Name",
                        mapResponse['first_name'].toString(), false),
                    buildTextField("Last Name",
                        mapResponse['last_name'].toString(), false),
                    // buildTextField(
                    //     "Email", mapResponse['email'].toString(), false),
                    buildTextField(
                        "Mobile", mapResponse['mobile'].toString(), false),
                    buildTextField(
                        "Address", mapResponse['address'].toString(), false),
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
