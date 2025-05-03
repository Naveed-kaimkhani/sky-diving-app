class UserModel {
  final int? id;
  final String name;
  final String email;
  final String phone;

  final String? password;
  final String? squareUserId;
  final String? refId;
  final String? invitedRefIds;
  final String? verificationId;
  final String? referralCode; // ✅ add this

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.squareUserId,
    this.referralCode,
    this.password,
    this.refId,
    this.invitedRefIds,
    this.verificationId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone_number'],
      squareUserId: json['square_user_id'],
      refId: json['ref_id'],
      invitedRefIds: json['invited_ref_ids'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone_number": phone,
      "password": password,
      "invited_by": refId??""
      // "invited_by": ""
    };
  }
}
