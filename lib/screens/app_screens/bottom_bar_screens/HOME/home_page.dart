import 'package:DentalHome/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:DentalHome/screens/app_screens/bottom_bar_screens/HOME/title_more_btn.dart';
import 'package:url_launcher/url_launcher.dart';

import 'recommend_service.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          RecommendsServices(),
        ],
      ),
    );
  }
}

Container _buildHeader() {
  return Container(
    height: 300.0,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Love your teeth',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            Text(
              'For quick query or services, please call or text us immediately',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  onPressed: () {
                    _makeCall();
                  },
                  color: Colors.greenAccent[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Call Now',
                  ),
                  textColor: Colors.white,
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  onPressed: () {
                    _makeMail();
                  },
                  color: Color(0xFF59c5f0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: const Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Contact Us',
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        )
      ],
    ),
  );
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
