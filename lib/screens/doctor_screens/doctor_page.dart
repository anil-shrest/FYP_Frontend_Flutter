import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/api/api.dart';

//  All doctor list and view screen
class DoctorPageScreen extends StatefulWidget {
  @override
  _DoctorPageScreenState createState() => _DoctorPageScreenState();
}

class _DoctorPageScreenState extends State<DoctorPageScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<AppointmentProvider>(context);
    int list_count = doctorProvider.doctor.length;
    print('Doctor count: $list_count');
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          ListView.builder(
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
                        'Nmc No: ' +
                            doctorProvider.doctor[index].nmc_number +
                            '\nSpeciality: ' +
                            doctorProvider.doctor[index].speciality +
                            '\nType: ' +
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
                      onTap: () {},
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
