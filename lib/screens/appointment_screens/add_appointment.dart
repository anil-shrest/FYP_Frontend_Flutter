// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simpleApi/api/api.dart';
// import 'package:simpleApi/models/appoint.dart';

// class AddAppointScreen extends StatefulWidget {
//   @override
//   _AddAppointScreenState createState() => _AddAppointScreenState();
// }

// class _AddAppointScreenState extends State<AddAppointScreen> {
//   final appointIdController = TextEditingController();
//   // final appointTypeController = TextEditingController();
//   // final appointDescController = TextEditingController();
//   final appointAppointByController = TextEditingController();
//   final appointAppointTimeController = TextEditingController();

//   void onSubmit() {
//     final String idVal = appointIdController.text;
//     // final String typeVal = appointTypeController.text;
//     // final String descVal = appointDescController.text;
//     final String appointBy = appointAppointByController.text;
//     final String appointTime = appointAppointTimeController.text;

//     if (
//         idVal.isNotEmpty &&
//         // typeVal.isNotEmpty &&
//         appointTime.isNotEmpty &&
//         appointBy.isNotEmpty) {
//       final Appointment appointment = Appointment(
//         id: int.parse(idVal),
//         // appointmentType: typeVal,
//         // appointmentDescription: descVal,
//         appointmentBy: appointBy,
//         appointmentTime: appointTime
//       );
//       Provider.of<AppointmentProvider>(context, listen: false)
//           .addAppoint(appointment);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('New Appointment'),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: appointIdController,
//                 ),
//                 // TextField(
//                 //   controller: appointTypeController,
//                 // ),
//                 // TextField(
//                 //   controller: appointDescController,
//                 // ),
//                 TextField(
//                   controller: appointAppointByController,
//                 ),
//                 TextField(
//                   controller: appointAppointTimeController,
//                 ),
//                 RaisedButton(
//                   child: Text('BOOK'),
//                   onPressed: () {
//                     onSubmit();
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
