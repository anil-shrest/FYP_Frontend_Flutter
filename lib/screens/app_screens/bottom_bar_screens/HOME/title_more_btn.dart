import 'package:flutter/material.dart';
import 'package:DentalHome/components/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.press,
  }) : super(key: key);
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0),
      child: Row(
        children: <Widget>[
          Text(
            'Services',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          FlatButton(
            onPressed: () => _launchUrl(),
            child: Row(
              children: [
                Text(
                  "More",
                  style: TextStyle(color: buttonColor),
                ),
                Icon(Icons.navigate_next, size: 20.0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// to open url in the browser to view more services
_launchUrl() async {
  const url = 'https://loveyourteethdentalclinic.business.site/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
