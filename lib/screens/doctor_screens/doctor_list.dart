import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'doctor_detail_page.dart';

// Doctor list view builder creation
class DoctorList extends StatefulWidget {
  DoctorList({
    Key key,
  }) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<AppointmentProvider>(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Doctors Involved',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3),
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: doctorProvider.doctor.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  // color: Colors.teal,
                  color: Color(0xFF2cd1a8),
                  elevation: 5.0,
                  child: Container(
                    height: 120.0,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          doctorProvider.doctor[index].full_name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          // 'Nmc No: ' +
                          //     doctorProvider.doctor[index].nmc_number +
                          //     '\nSpeciality: ' +
                          //     doctorProvider.doctor[index].speciality +
                          doctorProvider.doctor[index].doc_type,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        leading: Transform.scale(
                          scale: 1.8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://image.freepik.com/free-vector/online-doctor-concept_23-2148522555.jpg'),
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorsInfo(
                                        doc_name: doctorProvider
                                            .doctor[index].full_name,
                                        nmc_number: doctorProvider
                                            .doctor[index].nmc_number,
                                        doc_type: doctorProvider
                                            .doctor[index].doc_type,
                                        doc_image: doctorProvider
                                            .doctor[index].doc_image,
                                        doc_spec: doctorProvider
                                            .doctor[index].speciality,
                                      )));
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// //  All doctor list and view screen
// class DoctorPageScreen extends StatefulWidget {
//   const DoctorPageScreen(
//       {Key key,
//       this.doc_name,
//       this.nmc_number,
//       this.doc_image,
//       this.doc_type,
//       this.speciality,
//       this.navigateTo})
//       : super(key: key);

//   final String doc_name, doc_type, nmc_number, doc_image, speciality;
//   final Function navigateTo;

//   @override
//   _DoctorPageScreenState createState() => _DoctorPageScreenState();
// }

// class _DoctorPageScreenState extends State<DoctorPageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final doctorProvider = Provider.of<AppointmentProvider>(context);
//     // int list_count = doctorProvider.doctor.length;
//     // print('Doctor count: $list_count');
//     return Container(
//       child: Column(
//         children: [
//           SizedBox(height: 20.0),
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: doctorProvider.doctor.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0)),
//                 margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//                 // color: Colors.teal,
//                 color: Color(0xFF2cd1a8),
//                 elevation: 5.0,
//                 child: Container(
//                   height: 120.0,
//                   child: Center(
//                     child: ListTile(
//                       title: Text(
//                         doctorProvider.doctor[index].full_name,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         'Nmc No: ' +
//                             doctorProvider.doctor[index].nmc_number +
//                             '\nSpeciality: ' +
//                             doctorProvider.doctor[index].speciality +
//                             '\nType: ' +
//                             doctorProvider.doctor[index].doc_type,
//                         style: TextStyle(fontSize: 15, color: Colors.black),
//                       ),
//                       leading: Transform.scale(
//                         scale: 1.8,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 'https://image.freepik.com/free-vector/online-doctor-concept_23-2148522555.jpg'),
//                           ),
//                         ),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 20.0,
//                       ),
//                       onTap: widget.navigateTo,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Recommedation services main method
// class DoctorListBuilder extends StatefulWidget {
//   const DoctorListBuilder({
//     Key key,
//     this.image,
//     this.title,
//     this.press,
//   }) : super(key: key);

//   final String image, title;
//   final Function press;

//   @override
//   _DoctorListBuilderState createState() => _DoctorListBuilderState();
// }

// class _DoctorListBuilderState extends State<DoctorListBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     final serviceProvider = Provider.of<AppointmentProvider>(context);
//     // int list_count = serviceProvider.services.length;
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       // color: Colors.white,
//       padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
//       width: size.width * 0.6,
//       height: size.height * 0.2,
//       child: Column(children: [
//         Column(
//           children: [
//             Container(
//               width: size.width * 0.6,
//               height: size.height * 0.1,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),
//                 image: DecorationImage(
//                   image: widget.image != null
//                       ? NetworkImage('${widget.image}')
//                       : AssetImage('assets/gum.jpeg'),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: widget.press,
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10)),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 10),
//                       blurRadius: 15,
//                       color: Colors.black26,
//                     )
//                   ],
//                 ),
//                 child: Container(
//                   width: size.width * 0.6,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                             child: Text(
//                           '${widget.title}',
//                           style: TextStyle(
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[800]),
//                         )),
//                         Container(
//                           child: Text('Details',
//                               style: TextStyle(
//                                   fontSize: 14.0, color: Colors.deepPurple)),
//                         )
//                       ]),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }

// ListView.builder(
//               // scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemCount: serviceProvider.services.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return DoctorListBuilder(
//                   image: serviceProvider.services[index].service_image,
//                   title: serviceProvider.services[index].service_title,
//                   press: () {
//                     print(serviceProvider.services[index].service_image);
//                     indexProvider.indexValues(3);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => DetailsScreen(
//                                   title: serviceProvider
//                                       .services[index].service_title,
//                                   details: serviceProvider
//                                       .services[index].service_detail,
//                                   service_image: serviceProvider
//                                       .services[index].service_image,
//                                   doc_name: serviceProvider
//                                       .services[index].doctor.full_name,
//                                   nmc_number: serviceProvider
//                                       .services[index].doctor.nmc_number,
//                                   doc_image: serviceProvider
//                                       .services[index].doctor.photo,
//                                 )));
//                   },
//                 );
//               }),
