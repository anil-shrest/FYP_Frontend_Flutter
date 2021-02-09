import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/components/providers.dart';
import 'package:simpleApi/screens/app_screens/bottom_bar_screens/HOME/recommend_service.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}

// body of details page
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 8.0),
          DetialsImage(size: size),
          DetailsInfo(),
        ],
      ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  const DetailsInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indexProviders = Provider.of<Providers>(context, listen: false);
    int val = indexProviders.indexValue;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Root Canal Treatment\n',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: buttonColor, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '$val',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: buttonColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
              child: Text(
            'We provide the best root canal treatment using new technology which is quicker and less painful. We provide the best root canal treatment using new technology which is quicker and less painful.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
        ],
      ),
    );
  }
}

class DetialsImage extends StatelessWidget {
  const DetialsImage({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.6,
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    icon: SvgPicture.asset('assets/back_arrow.svg'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )),
            Container(
              height: size.height * 0.8,
              width: size.width * 0.83,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 70.0,
                        color: Colors.grey[700])
                  ],
                  image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/tool.jpeg')
                      // image: NetworkImage(
                      //     'https://images.pexels.com/photos/4269370/pexels-photo-4269370.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260')
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
