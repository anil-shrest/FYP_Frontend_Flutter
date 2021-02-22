import 'package:flutter/material.dart';

// import 'package:flutter_khalti/flutter_khalti.dart';
// import 'package:provider/provider.dart';
// import 'package:simpleApi/components/colors.dart';
// import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/screens/app_screens/landing_page.dart';

import 'khalti_screen.dart';

void main() => runApp(PaymentPageScreen());

class PaymentPageScreen extends StatefulWidget {
  @override
  _PaymentPageScreenState createState() => _PaymentPageScreenState();
}

class _PaymentPageScreenState extends State<PaymentPageScreen> {
  int val;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Card ceation
          PaymentCard(
            title: 'Fone Pay',
            subtitle: 'Easy scan and pay',
            image:
                'https://play-lh.googleusercontent.com/-Dh97DQp7zHwg8X03-vqTz-IuziW7ce3sz5_TBOMEcDFAnToXKlkEQ3lprVHy2Qq44ms',
            color: Colors.red,
            redirect: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LandingPage()));
            },
          ),
          PaymentCard(
            title: 'Khalti',
            subtitle: 'Pay or load amount with Khalti',
            image:
                'https://pbs.twimg.com/profile_images/1128188485255385088/ouU1wSp3_400x400.png',
            color: Colors.deepPurpleAccent,
            redirect: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KhaltiScreen()));
            },
          ),
        ],
      ),
    );
  }
}

// Widget fro payment card creation
class PaymentCard extends StatelessWidget {
  const PaymentCard(
      {Key key,
      this.title,
      this.subtitle,
      this.image,
      this.redirect,
      this.color})
      : super(key: key);
  final String title, subtitle, image;
  final Color color;
  final Function redirect;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            color: color,
            elevation: 5.0,
            child: Container(
              height: 120.0,
              child: Center(
                child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.2),
                      ),
                    ),
                    leading: Transform.scale(
                      scale: 1.9,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    onTap: redirect),
              ),
            ),
          )
        ],
      ),
    );
  }
}
