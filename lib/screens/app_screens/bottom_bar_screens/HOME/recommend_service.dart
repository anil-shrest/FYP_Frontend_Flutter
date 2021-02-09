import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/HOME/details_page.dart';

// Recommendation services view method
class RecommendsServices extends StatelessWidget {
  RecommendsServices({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indexProvider = Provider.of<Providers>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RecommedServices(
            image: 'assets/rct.jpg',
            title: 'Root Canal Treatment',
            press: () {
              indexProvider.indexValues(1);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen()));
            },
          ),
          RecommedServices(
            image: 'assets/crowns.jpeg',
            title: 'Crowns and Caps',
            press: () {
              indexProvider.indexValues(2);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen()));
            },
          ),
          RecommedServices(
            image: 'assets/gum.jpeg',
            title: 'Gum Surgery',
            press: () {
              indexProvider.indexValues(3);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen()));
            },
          ),
        ],
      ),
    );
  }
}

// Recommedation services main method
class RecommedServices extends StatelessWidget {
  const RecommedServices({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      width: size.width * 0.6,
      height: size.height * 0.2,
      child: Column(children: [
        Column(
          children: [
            Container(
              width: size.width * 0.6,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onTap: press,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      color: Colors.grey[300],
                    )
                  ],
                ),
                child: Container(
                  width: size.width * 0.6,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '$title',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text('Details',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.deepPurple)),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
