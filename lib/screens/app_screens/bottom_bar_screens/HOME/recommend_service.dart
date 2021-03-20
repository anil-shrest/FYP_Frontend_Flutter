import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DentalHome/api/api.dart';
import 'package:DentalHome/components/providers.dart';
import 'package:DentalHome/screens/app_screens/bottom_bar_screens/HOME/details_page.dart';

import 'home_screen_info.dart';
import 'title_more_btn.dart';

// Recommendation services view method
class RecommendsServices extends StatefulWidget {
  RecommendsServices({
    Key key,
  }) : super(key: key);

  @override
  _RecommendsServicesState createState() => _RecommendsServicesState();
}

class _RecommendsServicesState extends State<RecommendsServices> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<AppointmentProvider>(context);
    // int list_count = serviceProvider.services.length;
    // print('Services count: $list_count');
    // print(serviceProvider.services.first.doctor.full_name);
    var indexProvider = Provider.of<Providers>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text(
              'Home',
              style: TextStyle(fontSize: 22.0, letterSpacing: 0.2),
            ),
          ),
          // HomeScreenInfo(),
          // SizedBox(height: 40.0),
          SizedBox(height: 10.0),
          TitleWithMoreBtn(press: () {}),
          SizedBox(height: 8.0),
          SizedBox(
            height: 100.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: serviceProvider.services.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecommedServices(
                    image: serviceProvider.services[index].service_image,
                    title: serviceProvider.services[index].service_title,
                    press: () {
                      print(serviceProvider.services[index].service_image);
                      indexProvider.indexValues(3);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    title: serviceProvider
                                        .services[index].service_title,
                                    details: serviceProvider
                                        .services[index].service_detail,
                                    service_image: serviceProvider
                                        .services[index].service_image,
                                    doc_name: serviceProvider
                                        .services[index].doctor.full_name,
                                    nmc_number: serviceProvider
                                        .services[index].doctor.nmc_number,
                                    doc_image: serviceProvider
                                        .services[index].doctor.photo,
                                  )));
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 400.0,
              color: Colors.teal,
              child: Text('Wallpaper'),
            ),
          ),
          HomeScreenInfo(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

// Recommedation services main method
class RecommedServices extends StatefulWidget {
  const RecommedServices({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  _RecommedServicesState createState() => _RecommedServicesState();
}

class _RecommedServicesState extends State<RecommedServices> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<AppointmentProvider>(context);
    // int list_count = serviceProvider.services.length;
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      // width: size.width * 0.4,
      // height: size.height * 0.6,
      child: Column(children: [
        Column(
          children: [
            // Container(
            //   width: size.width * 0.6,
            //   height: size.height * 0.1,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         topRight: Radius.circular(10)),
            //     image: DecorationImage(
            //       image: widget.image != null
            //           ? NetworkImage('${widget.image}')
            //           : AssetImage('assets/gum.jpeg'),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: widget.press,
              child: Stack(children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.image != null
                          ? NetworkImage('${widget.image}')
                          : AssetImage('assets/gum.jpeg'),
                      fit: BoxFit.contain,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
                // Container(
                //   width: size.width * 0.6,
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //             child: Text(
                //           '${widget.title}',
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.grey[800]),
                //         )),
                //         // Container(
                //         //   child: Text('Details',
                //         //       style: TextStyle(
                //         //           fontSize: 14.0, color: Colors.deepPurple)),
                //         // )
                //       ]),
                // ),
              ]),
            )
          ],
        ),
      ]),
    );
  }
}
