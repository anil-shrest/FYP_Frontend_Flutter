class TimeTable {
  int id;
  final String time_space;
  final String doctor_name;
  // final String appointmentBy;
  // final String appDate;

  TimeTable({this.id, this.time_space, this.doctor_name});

  factory TimeTable.fromJson(Map<String, dynamic> json) {
    return TimeTable(
      id: json['id'],
      time_space: json['time_space'],
      doctor_name: json['doctor_name'],
      // appointmentType: json['appointmentType'],
      // appointmentDescription: json['appointmentDescription'],
      // appointmentBy: json['appointmentBy'],
      // appDate: json['appDate'],
    );
  }

  dynamic toJson() => {
        // 'id': id,
        'time_space': time_space,
        'doctor_name': doctor_name,
        // 'appointmentType': appointmentType,
        // 'appointmentDescription': appointmentDescription,
        // 'appointmentBy': appointmentBy,
        // 'appDate': appDate
      };
}
