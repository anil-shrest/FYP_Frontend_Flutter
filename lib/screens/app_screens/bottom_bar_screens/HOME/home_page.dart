import 'package:flutter/material.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/HOME/title_more_btn.dart';

import 'recommend_service.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 100.0),
      child: Column(
        children: [
          TitleWithMoreBtn(press: () {}),
          RecommendsServices(),
        ],
      ),
    );
  }
}
