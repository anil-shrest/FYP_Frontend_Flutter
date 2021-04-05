// class TimeTable {
//   int id;
//   final String time_space;
//   // final String doctor_name;
//   // final String appointmentBy;
//   // final String appDate;

//   TimeTable({this.id, this.time_space});

//   factory TimeTable.fromJson(Map<String, dynamic> json) {
//     return TimeTable(
//       id: json['id'],
//       time_space: json['time_space'],
//       // doctor_name: json['doctor_name'],
//       // appointmentType: json['appointmentType'],
//       // appointmentDescription: json['appointmentDescription'],
//       // appointmentBy: json['appointmentBy'],
//       // appDate: json['appDate'],
//     );
//   }

//   dynamic toJson() => {
//         'id': id,
//         'time_space': time_space,
//         // 'doctor_name': doctor_name,
//         // 'appointmentType': appointmentType,
//         // 'appointmentDescription': appointmentDescription,
//         // 'appointmentBy': appointmentBy,
//         // 'appDate': appDate
//       };
// }


class TimeTable {
  int id;
  String timeSpace;
  Doctors doctor;
  Author author;
  String doctorName;
  int staff;

  TimeTable(
      {this.id,
      this.timeSpace,
      this.doctor,
      this.author,
      this.doctorName,
      this.staff});

  TimeTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeSpace = json['time_space'];
    doctor =
        json['doctor'] != null ? new Doctors.fromJson(json['doctor']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    doctorName = json['doctor_name'];
    staff = json['staff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_space'] = this.timeSpace;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['doctor_name'] = this.doctorName;
    data['staff'] = this.staff;
    return data;
  }
}

class Doctors {
  int id;
  String fullName;
  String nmcNumber;
  String docType;
  String speciality;
  String photo;
  String createdAt;

  Doctors(
      {this.id,
      this.fullName,
      this.nmcNumber,
      this.docType,
      this.speciality,
      this.photo,
      this.createdAt});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    nmcNumber = json['nmc_number'];
    docType = json['doc_type'];
    speciality = json['speciality'];
    photo = json['photo'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['nmc_number'] = this.nmcNumber;
    data['doc_type'] = this.docType;
    data['speciality'] = this.speciality;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Author {
  int id;
  String password;
  String lastLogin;
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
      this.lastLogin,
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
    lastLogin = json['last_login'];
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
    data['last_login'] = this.lastLogin;
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
