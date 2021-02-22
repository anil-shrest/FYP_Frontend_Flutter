import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/components/providers.dart';

// Services Details UI view with specific data
class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {Key key,
      this.title,
      this.details,
      this.doc_name,
      this.nmc_number,
      this.doc_image})
      : super(key: key);

  final String title, details, doc_name, nmc_number, doc_image;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map mapResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(100.0),
                image: widget.doc_image != null
                    ? DecorationImage(
                        image: NetworkImage('${widget.doc_image}'),
                        fit: BoxFit.fill,
                      )
                    : DecorationImage(
                        image: AssetImage('assets/doctor_logo.png'),
                        fit: BoxFit.fill,
                      )),
            // child: Text('${widget.doc_image}')
          ),
          Text('${widget.title}'),
          Text('${widget.details}'),
          Text('${widget.doc_name}'),
          Text('${widget.nmc_number}'),
        ],
      )),
    );
  }
}

// // body of details page
// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: 8.0),
//           DetialsImage(size: size),
//           DetailsInfo(),
//         ],
//       ),
//     );
//   }
// }

// class DetailsInfo extends StatelessWidget {
//   const DetailsInfo({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var indexProviders = Provider.of<Providers>(context, listen: false);
//     int val = indexProviders.indexValue;
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 60.0),
//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                     text: 'Root Canal Treatment\n',
//                     style: Theme.of(context).textTheme.headline5.copyWith(
//                         color: buttonColor, fontWeight: FontWeight.bold)),
//                 TextSpan(
//                     text: '$val',
//                     style: Theme.of(context).textTheme.headline5.copyWith(
//                         color: buttonColor, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//           Container(
//               child: Text(
//             'We provide the best root canal treatment using new technology which is quicker and less painful. We provide the best root canal treatment using new technology which is quicker and less painful.',
//             textAlign: TextAlign.justify,
//             style: TextStyle(
//               fontSize: 16.0,
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }

// class DetialsImage extends StatelessWidget {
//   const DetialsImage({
//     Key key,
//     @required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size.height * 0.6,
//       child: Scaffold(
//         body: Row(
//           children: [
//             Expanded(
//                 child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     padding: EdgeInsets.symmetric(horizontal: 20.0),
//                     icon: SvgPicture.asset('assets/back_arrow.svg'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ],
//             )),
//             Container(
//               height: size.height * 0.8,
//               width: size.width * 0.83,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       bottomLeft: Radius.circular(30.0)),
//                   boxShadow: [
//                     BoxShadow(
//                         offset: Offset(0, 10),
//                         blurRadius: 70.0,
//                         color: Colors.grey[700])
//                   ],
//                   image: DecorationImage(
//                       alignment: Alignment.centerLeft,
//                       fit: BoxFit.cover,
//                       image: AssetImage('assets/tool.jpeg')
//                       // image: NetworkImage(
//                       //     'https://images.pexels.com/photos/4269370/pexels-photo-4269370.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260')
//                       )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
