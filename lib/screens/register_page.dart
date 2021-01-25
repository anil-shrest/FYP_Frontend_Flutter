import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/models/signup.dart';
import 'package:simpleApi/screens/loginPage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool hidePassword = true;

  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final userEmailController = TextEditingController();
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userPassword2Controller = TextEditingController();
  SignUpModel signUpModel;
  File _image;
  final _picker = ImagePicker();
  final scaffoldKey = GlobalKey<ScaffoldState>();

//  FOR UPLOADING IMAGE TO BACKEND
  static final String uploadEndPoint = 'http://10.0.2.2:8000/auth/register/';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errorMsg = 'Image Upload Failed';

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading...');
    if (null == tmpFile) {
      setStatus(errorMsg);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "profile_image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errorMsg);
    }).catchError((error) {
      setStatus(error);
    });
  }

  // File _image;

  // _imgFromGallery() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  void onSubmit() {
    final String first_name = firstNameController.text;
    final String last_name = lastNameController.text;
    final String mobile = mobileController.text;
    final String email = userEmailController.text;
    final String username = userNameController.text;
    final String password = userPasswordController.text;
    final String password2 = userPassword2Controller.text;

    // Provider.of<AppointmentProvider>(context, listen: false).signup(first_name, last_name, mobile, username, password);
    if (first_name.isNotEmpty &&
        last_name.isNotEmpty &&
        mobile.isNotEmpty &&
        email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty &&
        password2.isNotEmpty) {
      final SignUp signUp = SignUp(
        first_name: first_name,
        last_name: last_name,
        mobile: mobile,
        email: email,
        username: username,
        password: password,
        password2: password2,
      );
      Provider.of<AppointmentProvider>(context, listen: false).signup(signUp);
      // _showDialog();
    } else {
      showErrorSnackBar("Registeration Failed!");
    }
  }

  void showErrorSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
    signUpModel = new SignUpModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 12),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Text(
                          "Registration",
                          style:
                              (TextStyle(color: Colors.white, fontSize: 34.0)),
                        ),
                        SizedBox(height: 10),
                        // Center(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       _showImagePicker(context);
                        //     },
                        //     child: CircleAvatar(
                        //       radius: 55,
                        //       backgroundColor: Color(0xffFDCF09),
                        //       child: _image != null,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 30),
                        Center(
                          child: _image == null
                              ? MaterialButton(
                                  onPressed: getImage,
                                  color: Colors.blue,
                                  height: 80.0,
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 25,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  shape: CircleBorder(),
                                )
                              : Container(
                                  height: 80.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: const Color(0x33A6A6A6)),
                                    image: DecorationImage(
                                        image: Image.file(_image).image,
                                        fit: BoxFit.cover),
                                  )),
                          // child: _image == null
                          //     ? MaterialButton(
                          //         onPressed: getImage,
                          //         color: Colors.blue,
                          //         textColor: Colors.white,
                          //         child: Icon(
                          //           Icons.camera_alt,
                          //           size: 24,
                          //         ),
                          //         // padding: EdgeInsets.all(16),
                          //         // shape: CircleBorder(),
                          //       )
                          //     : CircleAvatar(child: Image.file(_image, fit: BoxFit.fill,),backgroundColor: Colors.brown.shade800, radius: 100,),
                        ),
                        SizedBox(height: 30),
                        _textField(
                            firstNameController,
                            'Do not leave this field empty *',
                            'First Name',
                            Icon(Icons.person, color: Colors.white)),
                        SizedBox(height: 20),
                        _textField(
                            lastNameController,
                            'Do not leave this field empty *',
                            'Last Name',
                            Icon(Icons.person, color: Colors.white)),
                        SizedBox(height: 20),
                        _textField(
                            mobileController,
                            'Do not leave this field empty *',
                            'Mobile',
                            Icon(Icons.phone, color: Colors.white)),
                        SizedBox(height: 20),
                        _textField(userEmailController, 'Enter a valid email *',
                            'Email', Icon(Icons.email, color: Colors.white)),
                        SizedBox(height: 20),
                        _textField(
                            userNameController,
                            'Enter a valid username *',
                            'Username',
                            Icon(Icons.admin_panel_settings,
                                color: Colors.white)),
                        SizedBox(height: 20),
                        _passwordTextField(
                            userPasswordController,
                            'Enter a strong password *',
                            'Password',
                            Icon(Icons.lock_open, color: Colors.white)),
                        SizedBox(height: 20),
                        _passwordTextField(
                            userPassword2Controller,
                            'Enter a strong password *',
                            'Confirm Password',
                            Icon(Icons.lock_open, color: Colors.white)),
                        SizedBox(height: 20),
                        FlatButton(
                            child: Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: StadiumBorder(),
                            color: Colors.black26,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () {
                              if (validateAndSave()) {
                                print("Checking user info :-");
                                print(signUpModel.toJson());

                                setState(() {
                                  isApiCallProcess = true;
                                });
                                // startUpload();
                                onSubmit();
                                _showDialog();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _textField(TextEditingController controller, String validator,
      String hintText, Icon icon) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: controller,
      validator: (input) => input.length < 4 ? "$validator" : null,
      decoration: new InputDecoration(
        hintText: "$hintText",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        prefixIcon: icon,
      ),
    );
  }

  _passwordTextField(TextEditingController controller, String validator,
      String hintText, Icon icon) {
    return new TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: TextInputType.text,
      // onSaved: (input) =>
      //     loginRequestModel.password = input,
      controller: controller,
      validator: (input) => input.length < 3 ? "$validator" : null,
      obscureText: hidePassword,
      decoration: new InputDecoration(
        hintText: "$hintText",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        prefixIcon: icon,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          color: Colors.white,
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('User Authentication'),
            content: Text(
                'You have been successfully regsitered and now you will be redirected to login page.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

// To upload profile images
  Future getImage() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  // _imgFromGallery() async {
  //   File image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = image;
  //   });
  // }
}
