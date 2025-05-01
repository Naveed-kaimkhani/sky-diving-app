class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? verificationId;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.verificationId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone_number": phone,
      "password": password,
    };
  }
}
