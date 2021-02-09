import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/data/sliderImageData.dart';
import 'package:simpleApi/screens/auth_screens/login_page.dart';

import 'main_menu_page.dart';

// class Splash extends StatefulWidget {
//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<SliderModel> mySlides = new List<SliderModel>();

  int slideIndex = 0;

  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySlides = getSlides();
    pageController = new PageController();
  }

  Widget buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey[600] : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Column(
          //   children: [
          //     Align(child: _titleInfo(), alignment: Alignment.topLeft),
          //   ],
          // ),
          PageView.builder(
            controller: pageController,
            itemCount: mySlides.length,
            onPageChanged: (val) {
              setState(() {
                slideIndex = val;
              });
            },
            itemBuilder: (context, index) {
              return SlideTile(
                imagePath: mySlides[index].getImageAssetPath(),
                title: mySlides[index].getTitle(),
                desc: mySlides[index].getDesc(),
              );
            },
          ),
        ],
      ),
      bottomSheet: slideIndex != mySlides.length - 1
          ? Container(
              height: Platform.isAndroid ? 50 : 70,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pageController.animateToPage(mySlides.length - 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.decelerate);
                      },
                      child: Text('SKIP',
                          style: TextStyle(
                              color: Colors.redAccent[200],
                              fontWeight: FontWeight.w600)),
                    ),
                    Row(children: [
                      for (int i = 0; i < mySlides.length; i++)
                        i == slideIndex
                            ? buildPageIndicator(true)
                            : buildPageIndicator(false),
                    ]),
                    GestureDetector(
                      onTap: () {
                        pageController.animateToPage(slideIndex + 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      child: Text('NEXT',
                          style: TextStyle(
                              color: buttonColor, fontWeight: FontWeight.w600)),
                    ),
                  ]),
            )
          : Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 120.0, vertical: 60.0),
                  child: InkWell(
                    onTap: () {
                      // FOR LOGIN VERIFICATION
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));

                      // FOR DEMO PURPOSE NO AUTH
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => MainMenu()));
                    },
                    child: new Container(
                      // width: 148.0,
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
                            SizedBox(width: 5.0),
                            Icon(Icons.navigate_next,
                                color: Colors.white, size: 25.0),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
    );
  }

  Widget _titleInfo() {
    return Container(
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
                    SizedBox(height: 30),
                    Text("Dental",
                        style: TextStyle(
                            // color: Colors.grey[700],
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    Text("Home Nepal",
                        style: TextStyle(
                            // color: Colors.grey[700],
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;
  SlideTile({this.imagePath, this.title, this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.height - 300,
              height: 300,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       fit: BoxFit.cover, image: AssetImage(imagePath)),
              //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //   // color: Colors.deepPurpleAccent,
              // ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              )),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: normalTextColor,
                  // fontWeight: FontWeight.w300,
                  fontSize: 15)),
        ],
      ),
    );
  }
}

// child: SafeArea(
//   child: Container(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 30),
//                   Text("Dental",
//                       style: TextStyle(
//                           // color: headingTextColor,
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.bold,
//                           fontSize: 28)),
//                   Text("Home Nepal",
//                       style: TextStyle(
//                           // color: headingTextColor,
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.bold,
//                           fontSize: 28)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),

// import 'dart:io';
// import 'package:app_onboarding/data/data.dart';
// import 'package:app_onboarding/data/main.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   List<SliderModel> mySLides = new List<SliderModel>();
//   int slideIndex = 0;
//   PageController controller;

//   Widget _buildPageIndicator(bool isCurrentPage){
//     return Container(
//      margin: EdgeInsets.symmetric(horizontal: 2.0),
//       height: isCurrentPage ? 10.0 : 6.0,
//       width: isCurrentPage ? 10.0 : 6.0,
//       decoration: BoxDecoration(
//         color: isCurrentPage ? Colors.grey : Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     mySLides = getSlides();
//     controller = new PageController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           height: MediaQuery.of(context).size.height - 100,
//           child: PageView(
//             controller: controller,
//               onPageChanged: (index) {
//                 setState(() {
//                   slideIndex = index;
//                 });
//               },
//           children: <Widget>[
//             SlideTile(
//               imagePath: mySLides[0].getImageAssetPath(),
//               title: mySLides[0].getTitle(),
//               desc: mySLides[0].getDesc(),
//             ),
//             SlideTile(
//               imagePath: mySLides[1].getImageAssetPath(),
//               title: mySLides[1].getTitle(),
//               desc: mySLides[1].getDesc(),
//             ),
//             SlideTile(
//               imagePath: mySLides[2].getImageAssetPath(),
//               title: mySLides[2].getTitle(),
//               desc: mySLides[2].getDesc(),
//             )
//           ],
//           ),
//         ),
//         bottomSheet: slideIndex != 2 ? Container(
//           margin: EdgeInsets.symmetric(vertical: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               FlatButton(
//                 onPressed: (){
//                   controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
//                 },
//                 splashColor: Colors.blue[50],
//                 child: Text(
//                   "SKIP",
//                   style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
//                   ],),
//               ),
//               FlatButton(
//                 onPressed: (){
//                   print("this is slideIndex: $slideIndex");
//                   controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
//                 },
//                 splashColor: Colors.blue[50],
//                 child: Text(
//                   "NEXT",
//                   style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ): InkWell(
//           onTap: (){
//             print("Get Started Now");
//           },
//           child: Container(
//             height: Platform.isIOS ? 70 : 60,
//             color: Colors.blue,
//             alignment: Alignment.center,
//             child: Text(
//               "GET STARTED NOW",
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SlideTile extends StatelessWidget {
//   String imagePath, title, desc;

//   SlideTile({this.imagePath, this.title, this.desc});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Image.asset(imagePath),
//           SizedBox(
//             height: 40,
//           ),
//           Text(title, textAlign: TextAlign.center,style: TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 20
//           ),),
//           SizedBox(
//             height: 20,
//           ),
//           Text(desc, textAlign: TextAlign.center,style: TextStyle(
//           fontWeight: FontWeight.w500,
//               fontSize: 14))
//         ],
//       ),
//     );
//   }
// }
