import 'package:flutter/material.dart';
import 'package:DentalHome/components/colors.dart';

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
            onPressed: press,
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
