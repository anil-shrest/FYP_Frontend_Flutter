import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    // Will provide total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 130.0),
      child: Column(
        children: [
          // Will cover 40% of the screen
          Container(
            width: size.width * 0.5,
            child: Column(children: [
              Image.asset('assets/booking.png'),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 60,
                      color: Colors.grey[400],
                    )
                  ],
                ),
                child: Row(children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          text: 'RCT\n',
                        ),
                        TextSpan(text: 'Root Canal Treatment'),
                      ],
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
