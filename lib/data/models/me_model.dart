class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String birthDate;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as int,
      fullName: json["fullName"] as String,
      email: json["email"] as String,
      phoneNumber: json["phoneNumber"] as String,
      gender: json["gender"] as String,
      birthDate: json["birthDate"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "birthDate": birthDate,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, gender: $gender, birthDate: $birthDate)';
  }
}
