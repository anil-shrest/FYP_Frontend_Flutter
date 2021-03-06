import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/models/appoint.dart';

class AddAppointScreen extends StatefulWidget {
  @override
  _AddAppointScreenState createState() => _AddAppointScreenState();
}

class _AddAppointScreenState extends State<AddAppointScreen> {
  final appointIdController = TextEditingController();
  final appointTypeController = TextEditingController();
  final appointDescController = TextEditingController();
  final appointAppointByController = TextEditingController();
  // final appointAppointDateController = TextEditingController();

  void onSubmit() {
    final String idVal = appointIdController.text;
    final String typeVal = appointTypeController.text;
    final String descVal = appointDescController.text;
    final String appointByVal = appointAppointByController.text;
    // final String appointDateVal = appointTypeController.text;

    if (
        idVal.isNotEmpty &&
        typeVal.isNotEmpty && descVal.isNotEmpty && appointByVal.isNotEmpty) {
      final Appointment appointment = Appointment(
        id: int.parse(idVal),
        appointmentType: typeVal,
        appointmentDescription: descVal,
        appointmentBy: appointByVal,
        // appDate: appointDateVal
      );
      Provider.of<AppointmentProvider>(context, listen: false)
          .addAppoint(appointment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Appointment'),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                TextField(
                  controller: appointIdController,
                ),
                TextField(
                  controller: appointTypeController,
                ),
                TextField(
                  controller: appointDescController,
                ),
                TextField(
                  controller: appointAppointByController,
                ),
                // TextField(
                //   controller: appointAppointDateController,
                // ),
                RaisedButton(
                  child: Text('BOOK'),
                  onPressed: () {
                    onSubmit();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
