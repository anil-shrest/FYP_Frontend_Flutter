class DoctorServices {
  int id;
  final String full_name;
  final String nmc_number;
  final String speciality;
  final String photo;

  DoctorServices(
      {this.id, this.full_name, this.nmc_number, this.speciality, this.photo});

  factory DoctorServices.fromJson(Map<String, dynamic> json) {
    return DoctorServices(
      id: json['id'],
      full_name: json['full_name'],
      nmc_number: json['nmc_number'],
      speciality: json['speciality'],
      photo: json['photo'],
    );
  }
}

class Services {
  int id;
  final String service_title;
  final String service_detail;
  final String service_image;
  final DoctorServices doctor;

  Services(
      {this.id,
      this.service_title,
      this.service_detail,
      this.service_image,
      this.doctor});

  factory Services.fromJson(Map<String, dynamic> parsedJson) {
    return Services(
      id: parsedJson['id'],
      service_title: parsedJson['service_title'],
      service_detail: parsedJson['service_detail'],
      service_image: parsedJson['service_image'],
      doctor: DoctorServices.fromJson(parsedJson['doctor']),
    );
  }
}
