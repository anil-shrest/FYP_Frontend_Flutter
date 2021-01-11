import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';
import 'package:simpleApi/models/appoint.dart';
import 'package:simpleApi/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final noteIdController = TextEditingController();
  final noteTitleController = TextEditingController();
  final noteBodyController = TextEditingController();
  // final appointAppointByController = TextEditingController();
  // final appointAppointDateController = TextEditingController();
  Note noteModel;

  void onSubmit() {
    final String idVal = noteIdController.text;
    final String titleVal = noteTitleController.text;
    final String bodyVal = noteBodyController.text;
    // final String appointByVal = appointAppointByController.text;
    // final String appointDateVal = appointTypeController.text;

    if (titleVal.isNotEmpty && bodyVal.isNotEmpty) {
      final Note note = Note(
        id: int.parse(idVal),
        title: titleVal,
        body: bodyVal,
        // appointmentBy: appointByVal,
        // appDate: appointDateVal
      );
      Provider.of<AppointmentProvider>(context, listen: false).addNote(note);
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
                  controller: noteIdController,
                ),
                TextField(
                  controller: noteTitleController,
                ),
                TextField(
                  controller: noteBodyController,
                ),
                // TextField(
                //   controller: appointAppointByController,
                // ),
                // TextField(
                //   controller: appointAppointDateController,
                // ),
                RaisedButton(
                  child: Text('SAVE'),
                  onPressed: () {
                    onSubmit();
                    print("Checking note info :-");
                    // print(noteModel.toJson());
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
