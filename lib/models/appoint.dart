class DoctorAppointment {
  int id;
  final String full_name;
  final String nmc_number;
  final String speciality;
  final String photo;

  DoctorAppointment(
      {this.id, this.full_name, this.nmc_number, this.speciality, this.photo});

  factory DoctorAppointment.fromJson(Map<String, dynamic> json) {
    return DoctorAppointment(
      id: json['id'],
      full_name: json['full_name'],
      nmc_number: json['nmc_number'],
      speciality: json['speciality'],
      photo: json['photo'],
    );
  }
}

class Appointment {
  int id;
  // final String appointmentType;
  // final String appointmentDescription;
  // int appointmentBy;
  final String appointmentTime;
  final DoctorAppointment appointmentBy;

  Appointment({this.id, this.appointmentTime, this.appointmentBy});

  factory Appointment.fromJson(Map<String, dynamic> parsedJson) {
    return Appointment(
      id: parsedJson['id'],
      // appointmentType: json['appointmentType'],
      // appointmentDescription: json['appointmentDescription'],
      // appointmentBy: parsedJson['appointmentBy'],
      appointmentTime: parsedJson['appointmentTime'],
      appointmentBy: DoctorAppointment.fromJson(parsedJson['appointmentBy']),
      // appointmentBy: DoctorAppointment.fromJson(parsedJson['appointmentBy']),
    );
  }
}
