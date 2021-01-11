class Appointment {
  int id;
  final String appointmentType;
  final String appointmentDescription;
  final String appointmentBy;
  // final String appDate;

  Appointment(
      {this.id, this.appointmentType, this.appointmentDescription, this.appointmentBy});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      appointmentType: json['appointmentType'],
      appointmentDescription: json['appointmentDescription'],
      appointmentBy: json['appointmentBy'],
      // appDate: json['appDate'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'appointmentType': appointmentType,
        'appointmentDescription': appointmentDescription,
        'appointmentBy': appointmentBy,
        // 'appDate': appDate
      };
}
