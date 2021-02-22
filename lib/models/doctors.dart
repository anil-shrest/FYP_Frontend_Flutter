class Doctor {
  int id;
  final String full_name;
  final String nmc_number;
  final String doc_type;
  final String speciality;

  Doctor(
      {this.id,
      this.full_name,
      this.nmc_number,
      this.doc_type,
      this.speciality});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      full_name: json['full_name'],
      nmc_number: json['nmc_number'],
      doc_type: json['doc_type'],
      speciality: json['speciality'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'full_name': full_name,
        'nmc_number': nmc_number,
        'doc_type': doc_type,
        'speciality': speciality,
      };
}
