class SignUp {
  int id;
  final String first_name;
  final String last_name;
  final String mobile;
  final String email;
  final String username;
  final String password;
  final String password2;

  SignUp(
      {this.id,
      this.first_name,
      this.last_name,
      this.mobile,
      this.email,
      this.username,
      this.password,
      this.password2});

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      mobile: json['mobile'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      password2: json['password2'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'first_name': first_name,
        'last_name': last_name,
        'mobile': mobile,
        'email': email,
        'username': username,
        'password': password,
        'password2': password2,
      };
}

class SignUpModel {
  int id;
  String first_name;
  String last_name;
  String mobile;
  String email;
  String username;
  String password;
  String password2;

  SignUpModel(
      {this.id,
      this.first_name,
      this.last_name,
      this.mobile,
      this.email,
      this.username,
      this.password,
      this.password2
      });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'mobile': mobile,
      'email': email,
      'username': username,
      'password': password,
      'password2': password2,
    };
    return map;
  }
}
