import 'package:flutter/material.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:url_launcher/url_launcher.dart';

// Services Details UI view with specific data
class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({
    Key key,
    this.doc_name,
    this.nmc_number,
    this.doc_spec,
    this.doc_type,
    this.doc_image,
  }) : super(key: key);

  final String doc_name, doc_spec, nmc_number, doc_image, doc_type;

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  // For scrollable app bar and body contents

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.doc_name}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2)),
        backgroundColor: buttonColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                // color: Colors.purple[100],
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  image: widget.doc_image != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              '${widget.doc_image}'),
                                          fit: BoxFit.contain,
                                        )
                                      : DecorationImage(
                                          image:
                                              AssetImage('assets/UserLogo.png'),
                                          fit: BoxFit.contain,
                                        )),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          '${widget.doc_name}',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal),
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5.0),
                            Text(
                              'Doctor Type: ${widget.doc_type}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.0),

                            Text(
                              'Nmc ${widget.nmc_number}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.0),

                            Text(
                              'Specialization: ${widget.doc_spec}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(color: Colors.deepPurpleAccent),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF42d1a8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print('tap');
                                },
                                icon: Icon(Icons.bookmark,
                                    color: Colors.white, size: 30.0),
                              ),
                              Text('BOOK')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print('tap');
                                },
                                icon: Icon(Icons.phone,
                                    color: Colors.white, size: 30.0),
                              ),
                              Text('CALL')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.info,
                                    color: Colors.white, size: 30.0),
                              ),
                              Text('INFO')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorsInfo extends StatefulWidget {
  final String doc_name, doc_spec, nmc_number, doc_image, doc_type;

  const DoctorsInfo(
      {Key key,
      this.doc_name,
      this.doc_spec,
      this.nmc_number,
      this.doc_image,
      this.doc_type})
      : super(key: key);
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: buttonColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   child: Text('Doctor Details'),
              // ),
              Row(
                children: <Widget>[
                  Container(
                    width: 140.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: widget.doc_image != null
                            ? DecorationImage(
                                image: NetworkImage('${widget.doc_image}'),
                                fit: BoxFit.contain,
                              )
                            : DecorationImage(
                                image: AssetImage('assets/dentist.jpg'),
                                fit: BoxFit.cover,
                              )),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 212,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.doc_name}",
                          style: TextStyle(fontSize: 25, letterSpacing: 0.4),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "${widget.doc_type}",
                          style: TextStyle(
                              fontSize: 17,
                              color: buttonColor,
                              letterSpacing: 0.3),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _makeMail();
                              },
                              child: IconTile(
                                backColor: Color(0xffFFECDD),
                                imgAssetPath:
                                    "https://raw.githubusercontent.com/theindianappguy/doctor_booking_app/master/assets/email.png",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _makeCall();
                              },
                              child: IconTile(
                                backColor: Colors.greenAccent[100],
                                imgAssetPath:
                                    "https://raw.githubusercontent.com/theindianappguy/doctor_booking_app/master/assets/call.png",
                              ),
                            ),
                            IconTile(
                              backColor: Colors.blue[100],
                              imgAssetPath:
                                  "https://raw.githubusercontent.com/theindianappguy/doctor_booking_app/master/assets/video_call.png",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22, letterSpacing: 0.3),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Dr. Stefeni Albert is a cardiologist in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 17, letterSpacing: 0.3),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset('assets/nmc.png', height: 30.0),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Text(
                                "NMC Number",
                                style: TextStyle(
                                    // color: Colors.black87.withOpacity(0.7),
                                    letterSpacing: 0.2,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                    "${widget.nmc_number}",
                                    style: TextStyle(
                                        color: buttonColor,
                                        fontSize: 15.0,
                                        letterSpacing: 0.3),
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset('assets/specialty2.png'),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Speciality",
                                style: TextStyle(
                                    // color: Colors.black87.withOpacity(0.7),
                                    letterSpacing: 0.2,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                    '${widget.doc_spec}',
                                    style: TextStyle(
                                        color: buttonColor,
                                        letterSpacing: 0.3,
                                        fontSize: 15.0),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Divider(color: Colors.black87, height: 1),
              // SizedBox(height: 20.0),
              // Text(
              //   "Feedbacks",
              //   style: TextStyle(
              //       color: Colors.grey[700],
              //       fontSize: 25,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 22,
              // ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Container(
              //         padding:
              //             EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              //         decoration: BoxDecoration(
              //             color: Color(0xffFBB97C),
              //             borderRadius: BorderRadius.circular(20)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Container(
              //                 padding: EdgeInsets.all(8),
              //                 decoration: BoxDecoration(
              //                     color: Color(0xffFCCA9B),
              //                     borderRadius: BorderRadius.circular(16)),
              //                 child: Image.network(
              //                     "https://raw.githubusercontent.com/theindianappguy/doctor_booking_app/master/assets/list.png")),
              //             SizedBox(
              //               width: 16,
              //             ),
              //             Container(
              //               width: MediaQuery.of(context).size.width / 2 - 130,
              //               child: Text(
              //                 "List Of Schedule",
              //                 style:
              //                     TextStyle(color: Colors.white, fontSize: 17),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 16,
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding:
              //             EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              //         decoration: BoxDecoration(
              //             color: Color(0xffA5A5A5),
              //             borderRadius: BorderRadius.circular(20)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Container(
              //                 padding: EdgeInsets.all(8),
              //                 decoration: BoxDecoration(
              //                     color: Color(0xffBBBBBB),
              //                     borderRadius: BorderRadius.circular(16)),
              //                 child: Image.network(
              //                     "https://raw.githubusercontent.com/theindianappguy/doctor_booking_app/master/assets/list.png")),
              //             SizedBox(
              //               width: 16,
              //             ),
              //             Container(
              //               width: MediaQuery.of(context).size.width / 2 - 130,
              //               child: Text(
              //                 "Doctor's Daily Post",
              //                 style:
              //                     TextStyle(color: Colors.white, fontSize: 17),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.network(
          imgAssetPath,
          width: 15,
        ),
      ),
    );
  }
}

// to open phone app to make a call
_makeCall() async {
  const url = 'tel:4433221';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// to send mail
_makeMail() async {
  const url = 'mailto:dental.home@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
