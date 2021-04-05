import 'package:DentalHome/components/colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:DentalHome/models/clinic_location.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // ThemeNotifier themeChangeProvider = new ThemeNotifier();
  GoogleMapController _controller;

  PageController _pageController;
  int prevPage;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 12.0);

  final List<Marker> markers = [];

  // function to add a marker on the map
  // addMarker(cordinate) {
  //   int id = Random().nextInt(100);
  //   setState(() {
  //     markers
  //         .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // to load required data in the intial phase for location info
    clinicDetails.forEach((element) {
      markers.add(Marker(
          markerId: MarkerId(element.name),
          draggable: false,
          infoWindow: InfoWindow(title: element.name, snippet: element.address),
          position: element.locationCordinates));
      _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
        ..addListener(_onScroll);
    });
  }

  // to take user to a specific place according to scroll of items
  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  // designing details of location (slide-able) along with sliding animations
  _clinicList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.6).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 125.0,
            width: Curves.easeOut.transform(value) * 320.0,
            child: widget,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  height: 135.0,
                  width: 285.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 90.0,
                          width: 90.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    clinicDetails[index].thumbnail),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              clinicDetails[index].name,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              clinicDetails[index].address,
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              width: 170.0,
                              child: Text(
                                clinicDetails[index].description,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Branch Locations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: buttonColor,
      ),
      body: Stack(children: <Widget>[
        Container(
          // height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            onMapCreated: mapCreated,
            markers: Set.from(markers),
            onTap: (cordinate) {
              _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
              // addMarker(cordinate);
            },
          ),
        ),
        Positioned(
          bottom: 10.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: clinicDetails.length,
              itemBuilder: (BuildContext context, int index) {
                return _clinicList(index);
              },
            ),
          ),
        ),
      ]),
    );
  }

  // function to run when map created initially
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  // function to move camera view when tapped on certain scrollable cards in map
  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: clinicDetails[_pageController.page.toInt()].locationCordinates,
      zoom: 18.0,
      bearing: 45.0,
      tilt: 50.0,
    )));
  }
}
