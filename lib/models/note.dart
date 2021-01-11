class Note {
  int id;
  final String title;
  final String body;
  // final String appointmentBy;
  // final String appDate;

  Note(
      {this.id, this.title, this.body});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      // appointmentType: json['appointmentType'],
      // appointmentDescription: json['appointmentDescription'],
      // appointmentBy: json['appointmentBy'],
      // appDate: json['appDate'],
    );
  }

  dynamic toJson() => {
        // 'id': id,
        'title': title,
        'body': body,
        // 'appointmentType': appointmentType,
        // 'appointmentDescription': appointmentDescription,
        // 'appointmentBy': appointmentBy,
        // 'appDate': appDate
      };
}
