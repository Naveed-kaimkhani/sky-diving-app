class UserModel {
  final int? id;
  final String name;
  final String lastName;

  final String email;
  final String phone;

  final String? proiflePic;
  final String? password;
  final String? squareUserId;
  final String? refId;
  final String? invitedRefIds;
  final String? verificationId;
  final String? referralCode; // ✅ add this

  UserModel({
    this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    this.squareUserId,
    this.referralCode,
    this.password,
    this.refId,
    this.proiflePic,
    this.invitedRefIds,
    this.verificationId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['first_name'],

      proiflePic: json['avatar_url']??"",

      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone_number'],
      squareUserId: json['square_user_id'],
      refId: json['ref_id'],
      invitedRefIds: json['invited_ref_ids'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": name,
      "last_name": lastName,
      "email": email,
      "phone_number": phone,
      "password": password,
      "invited_by": refId ?? ""
      // "invited_by": ""
    };
  }
}
