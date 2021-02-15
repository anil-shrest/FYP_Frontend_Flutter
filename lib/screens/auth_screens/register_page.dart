import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/screens/auth_screens/login_page.dart';
import 'package:simpleApi/models/signup.dart';

// Sign up screen
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
  final addressController = TextEditingController();
  final userEmailController = TextEditingController();
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userPassword2Controller = TextEditingController();
  SignUpModel signUpModel;
  File _image;
  final _picker = ImagePicker();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String mobile_value;

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

  // startUpload() {
  //   setStatus('Uploading...');
  //   if (null == tmpFile) {
  //     setStatus(errorMsg);
  //     return;
  //   }
  //   String fileName = tmpFile.path.split('/').last;
  //   upload(fileName);
  // }

  // upload(String fileName) {
  //   http.post(uploadEndPoint, body: {
  //     "profile_image": base64Image,
  //     "name": fileName,
  //   }).then((result) {
  //     setStatus(result.statusCode == 200 ? result.body : errorMsg);
  //   }).catchError((error) {
  //     setStatus(error);
  //   });
  // }

  // void onSubmit() {
  //   final String first_name = firstNameController.text;
  //   final String last_name = lastNameController.text;
  //   final String mobile = mobileController.text;
  //   final String address = addressController.text;
  //   final String email = userEmailController.text;
  //   final String username = userNameController.text;
  //   final String password = userPasswordController.text;
  //   final String password2 = userPassword2Controller.text;

  //   // Provider.of<AppointmentProvider>(context, listen: false).signup(first_name, last_name, mobile, username, password);
  //   if (first_name.isNotEmpty &&
  //       last_name.isNotEmpty &&
  //       mobile.isNotEmpty &&
  //       address.isNotEmpty &&
  //       email.isNotEmpty &&
  //       username.isNotEmpty &&
  //       password.isNotEmpty &&
  //       password2.isNotEmpty) {
  //     final SignUp signUp = SignUp(
  //       first_name: first_name,
  //       last_name: last_name,
  //       mobile: mobile,
  //       address: address,
  //       email: email,
  //       username: username,
  //       password: password,
  //       password2: password2,
  //     );
  //     Provider.of<AppointmentProvider>(context, listen: false).signup(signUp);
  //     // _showDialog();
  //   } else {
  //     showErrorSnackBar("Registeration Failed!");
  //   }
  // }

  void showErrorSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
    signUpModel = new SignUpModel();
  }

// Text and image fields for registration
  @override
  Widget build(BuildContext context) {
    // final mobileNotify = Provider.of<Providers>(context);
    // mobile_value = mobileNotify.mobileNumber;
    return Stack(children: [
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
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Center(
                            child: _image == null
                                ? MaterialButton(
                                    onPressed: getImage,
                                    color: primaryColor,
                                    height: 80.0,
                                    textColor: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        SizedBox(height: 3.0),
                                        Text(
                                          'Select Image',
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ],
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
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Please enter your details to register",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[800]),
                          ),
                          SizedBox(height: 20),
                          _textField(
                              firstNameController,
                              'Do not leave this field empty *',
                              'First Name',
                              Icon(
                                Icons.person,
                                color: Colors.grey[700],
                              )),
                          SizedBox(height: 20),
                          _textField(
                              lastNameController,
                              'Do not leave this field empty *',
                              'Last Name',
                              Icon(
                                Icons.person,
                                color: Colors.grey[700],
                              )),
                          SizedBox(height: 20),
                          TextFormField(
                            enableInteractiveSelection:
                                false, // will disable paste operation
                            focusNode: new AlwaysDisabledFocusNode(),
                            initialValue: '+9779843291455',
                            // controller: mobileController,
                            style: TextStyle(color: Colors.grey[800]),
                            // keyboardType: TextInputType.number,
                            maxLength: 15,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // controller: mobileController,
                            validator: (input) => input.length < 3
                                ? "Do not leave this field empty *"
                                : null,
                            decoration: new InputDecoration(
                              counterText: '',
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 11.0),
                              // hintText: mobile_value,
                              // prefixText: '+977',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: primaryColor,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black87,
                              )),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          _textField(
                              addressController,
                              'Enter a valid address *',
                              'Address',
                              Icon(
                                Icons.location_pin,
                                color: Colors.grey[700],
                              )),
                          SizedBox(height: 20),
                          _textField(
                              userEmailController,
                              'Enter a valid email *',
                              'Email',
                              Icon(
                                Icons.email,
                                color: Colors.grey[700],
                              )),
                          SizedBox(height: 20),
                          _textField(
                              userNameController,
                              'Enter a valid username *',
                              'Username',
                              Icon(
                                Icons.admin_panel_settings,
                                color: Colors.grey[700],
                              )),
                          SizedBox(height: 20),
                          _passwordTextField(
                              userPasswordController,
                              'Enter a strong password *',
                              'Password',
                              Icon(Icons.lock_open, color: Colors.grey[700])),
                          SizedBox(height: 20),
                          _passwordTextField(
                              userPassword2Controller,
                              'Enter a strong password *',
                              'Confirm Password',
                              Icon(Icons.lock_clock, color: Colors.grey[700])),
                          SizedBox(height: 30.0),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 43.0,
                            child: FlatButton(
                                // padding: EdgeInsets.symmetric(
                                //     vertical: 14.0, horizontal: 138.0),
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: buttonTextColor, fontSize: 16.0),
                                ),
                                // shape: StadiumBorder(),
                                color: primaryColor,
                                onPressed: () async {
                                  // final String mobile = mobileController.text;
                                  print(mobileController.text);

                                  if (validateAndSave()) {
                                    print("Checking user info :-");
                                    print(signUpModel.toJson());

                                    setState(() {
                                      isApiCallProcess = true;
                                    });
                                    // onSubmit();
                                    // text field controllers
                                    final String first_name =
                                        firstNameController.text;
                                    final String last_name =
                                        lastNameController.text;
                                    // final String mobile = mobileController.text;
                                    final String address =
                                        addressController.text;
                                    final String email =
                                        userEmailController.text;
                                    final String username =
                                        userNameController.text;
                                    final String password =
                                        userPasswordController.text;
                                    final String password2 =
                                        userPassword2Controller.text;

                                    _upload(
                                        first_name,
                                        last_name,
                                        // mobile,
                                        address,
                                        email,
                                        username,
                                        password,
                                        password2,
                                        _image);
                                    _showDialog();
                                  }
                                }),
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already Registered?",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      " Login Now",
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
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

// Password field creation
  _passwordTextField(TextEditingController controller, String validator,
      String hintText, Icon icon) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: new TextFormField(
        style: TextStyle(color: Colors.grey[800]),
        keyboardType: TextInputType.text,
        controller: controller,
        validator: (input) => input.length < 3 ? "$validator" : null,
        obscureText: hidePassword,
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 11.0),
          fillColor: Colors.white,
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
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            color: Colors.grey[700],
            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }

// Dialog for auth confirmation
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

// Validating text fields before saving
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
    PickedFile image = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);

    setState(() {
      _image = File(image.path);
    });
  }

// Signing the user with proper credentials in the backend
  void _upload(String fName, String lName, String address, String email,
      String username, String password, String password2, File image) async {
    final mobileNotify = Provider.of<Providers>(context, listen: false);
    mobile_value = mobileNotify.mobileNumber;
    Dio dio = new Dio();

    try {
      String imageFileName = image.path.split('/').last;
      FormData data = FormData.fromMap({
        'first_name': fName,
        'last_name': lName,
        'mobile': '+9779876777',
        'address': address,
        'email': email,
        'username': username,
        'password': password,
        'password2': password2,
        'profile_image': await MultipartFile.fromFile(
          image.path,
          filename: imageFileName,
        ),
      });

      final response = await dio.post("http://10.0.2.2:8000/auth/register/",
          data: data,
          options: Options(contentType: 'multipart/form-data', headers: {
            "Accept": "application/json",
          }));
      if (response.statusCode == 200) {
        print('User Registered!');
      } else {
        print('Registeration failed X');
      }
    } catch (e) {
      print('File upload failed!');
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
