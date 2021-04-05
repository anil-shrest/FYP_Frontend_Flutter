// class DoctorAppointment {
//   int id;
//   final String full_name;
//   final String nmc_number;
//   final String speciality;
//   final String photo;

//   DoctorAppointment(
//       {this.id, this.full_name, this.nmc_number, this.speciality, this.photo});

//   factory DoctorAppointment.fromJson(Map<String, dynamic> json) {
//     return DoctorAppointment(
//       id: json['id'],
//       full_name: json['full_name'],
//       nmc_number: json['nmc_number'],
//       speciality: json['speciality'],
//       photo: json['photo'],
//     );
//   }
// }

// class Appointment {
//   int id;
//   final String created_at;
//   final String appointmentTime;
//   final DoctorAppointment appointmentBy;

//   Appointment(
//       {this.id, this.appointmentTime, this.appointmentBy, this.created_at});

//   factory Appointment.fromJson(Map<String, dynamic> parsedJson) {
//     return Appointment(
//       id: parsedJson['id'],
//       // appointmentType: json['appointmentType'],
//       // appointmentDescription: json['appointmentDescription'],
//       // appointmentBy: parsedJson['appointmentBy'],
//       appointmentTime: parsedJson['appointmentTime'],
//       appointmentBy: DoctorAppointment.fromJson(parsedJson['appointmentBy']),
//       created_at: parsedJson['created_at'],
//       // appointmentBy: DoctorAppointment.fromJson(parsedJson['appointmentBy']),
//     );
//   }
// }


class Appointment {
  int id;
  String username;
  String doctor;
  String appointmentTime;
  String createdAt;
  String updatedAt;
  AppointmentBy appointmentBy;
  Author author;

  Appointment(
      {this.id,
      this.username,
      this.doctor,
      this.appointmentTime,
      this.createdAt,
      this.updatedAt,
      this.appointmentBy,
      this.author});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    doctor = json['doctor'];
    appointmentTime = json['appointmentTime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appointmentBy = json['appointmentBy'] != null
        ? new AppointmentBy.fromJson(json['appointmentBy'])
        : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['doctor'] = this.doctor;
    data['appointmentTime'] = this.appointmentTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.appointmentBy != null) {
      data['appointmentBy'] = this.appointmentBy.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    return data;
  }
}

class AppointmentBy {
  int id;
  String fullName;
  String nmcNumber;
  String docType;
  String speciality;
  String photo;

  AppointmentBy(
      {this.id,
      this.fullName,
      this.nmcNumber,
      this.docType,
      this.speciality,
      this.photo});

  AppointmentBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    nmcNumber = json['nmc_number'];
    docType = json['doc_type'];
    speciality = json['speciality'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['nmc_number'] = this.nmcNumber;
    data['doc_type'] = this.docType;
    data['speciality'] = this.speciality;
    data['photo'] = this.photo;
    return data;
  }
}

class Author {
  int id;
  String password;
  // Null lastLogin;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String username;
  String address;
  String profileImage;
  String startDate;
  bool isStaff;
  bool isAdmin;
  bool isSuperuser;
  bool isActive;

  Author(
      {this.id,
      this.password,
      // this.lastLogin,
      this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.username,
      this.address,
      this.profileImage,
      this.startDate,
      this.isStaff,
      this.isAdmin,
      this.isSuperuser,
      this.isActive});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    // lastLogin = json['last_login'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    username = json['username'];
    address = json['address'];
    profileImage = json['profile_image'];
    startDate = json['start_date'];
    isStaff = json['is_staff'];
    isAdmin = json['is_admin'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    // data['last_login'] = this.lastLogin;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['username'] = this.username;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['start_date'] = this.startDate;
    data['is_staff'] = this.isStaff;
    data['is_admin'] = this.isAdmin;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    return data;
  }
}
