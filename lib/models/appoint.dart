class Appointment {
  int id;
  // final String appointmentType;
  // final String appointmentDescription;
  final String appointmentBy;
  final String appointmentTime;

  Appointment(
      {this.id, this.appointmentBy, this.appointmentTime});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      // appointmentType: json['appointmentType'],
      // appointmentDescription: json['appointmentDescription'],
      appointmentBy: json['appointmentBy'],
      appointmentTime: json['appointmentTime'],
    );
  }

  dynamic toJson() => {
        'id': id,
        // 'appointmentType': appointmentType,
        // 'appointmentDescription': appointmentDescription,
        'appointmentBy': appointmentBy,
        'appointmentTime': appointmentTime,
      };
}
