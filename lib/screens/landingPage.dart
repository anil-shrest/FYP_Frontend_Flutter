import 'package:flutter/material.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/screens/loginPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dental",
                            style: TextStyle(
                                color: headingTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Text("Home Nepal",
                            style: TextStyle(
                                color: headingTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child:
                    Text('''Visit to experience the best dental service in town 
                from from experienced Dentists.''',
                        style: TextStyle(
                            color: normalTextColor,
                            // fontWeight: FontWeight.w300,
                            fontSize: 15)),
              ),
              Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: new Container(
                      width: 148.0,
                      height: 44.0,
                      decoration: new BoxDecoration(
                        color: buttonColor,
                        // border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(6.0),
                      ),
                      child: new Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(
                              'Get Started',
                              style: new TextStyle(
                                  fontSize: 18.0, color: buttonTextColor),
                            ),
                            SizedBox(width: 6.0),
                            Icon(Icons.navigate_next, color: Colors.white, size: 25.0),
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/initialbg1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null /* add child content here */,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
