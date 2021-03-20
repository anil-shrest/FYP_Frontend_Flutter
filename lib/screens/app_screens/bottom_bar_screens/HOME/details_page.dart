import 'package:flutter/material.dart';
import 'package:DentalHome/components/colors.dart';

// Services Details UI view with specific data
class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {Key key,
      this.title,
      this.details,
      this.doc_name,
      this.nmc_number,
      this.doc_image,
      this.service_image})
      : super(key: key);

  final String title, details, service_image, doc_name, nmc_number, doc_image;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // For scrollable app bar and body contents
  nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: buttonColor,
            expandedHeight: 300.0,
            floating: true,
            title: Text(
              '${widget.title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Image.network(
                  'https://image.freepik.com/free-vector/flat-dentist-pattern_23-2148104069.jpg',
                  fit: BoxFit.cover),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                // color: Colors.purple[100],
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.title}',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: buttonColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      '${widget.details}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 10.0),
                    Divider(color: Colors.deepPurpleAccent),
                    SizedBox(height: 40.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF42d1a8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print('tap');
                                },
                                icon: Icon(Icons.bookmark,
                                    color: Colors.white, size: 30.0),
                              ),
                              Text('BOOK')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print('tap');
                                },
                                icon: Icon(Icons.phone,
                                    color: Colors.white, size: 30.0),
                              ),
                              Text('CALL')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.info,
                                    color: Colors.white, size: 30.0),
                              ),
                              Text('INFO')
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60.0),
                    Container(
                        child: Text(
                      'Associate Specialist',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              image: widget.doc_image != null
                                  ? DecorationImage(
                                      image:
                                          NetworkImage('${widget.doc_image}'),
                                      fit: BoxFit.contain,
                                    )
                                  : DecorationImage(
                                      image: AssetImage('assets/UserLogo.png'),
                                      fit: BoxFit.contain,
                                    )),
                        ),
                        SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.doc_name}',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.teal),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'NMC ${widget.nmc_number}',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: nested(),
      //  Scaffold(
      //     body: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Container(
      //       width: MediaQuery.of(context).size.width,
      //       height: MediaQuery.of(context).size.height / 2,
      //       decoration: BoxDecoration(
      //           // borderRadius: BorderRadius.circular(100.0),
      //           image: widget.doc_image != null
      //               ? DecorationImage(
      //                   image: NetworkImage('${widget.doc_image}'),
      //                   fit: BoxFit.fill,
      //                 )
      //               : DecorationImage(
      //                   image: AssetImage('assets/doctor_logo.png'),
      //                   fit: BoxFit.fill,
      //                 )),
      //       // child: Text('${widget.doc_image}')
      //     ),
      //     Text('${widget.title}'),
      //     Text('${widget.details}'),
      //     Text('${widget.doc_name}'),
      //     Text('${widget.nmc_number}'),
      //   ],
      // ),
      // ),
    );
  }
}

