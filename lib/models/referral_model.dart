class Referral {
  final int id;
  final String referredName;
  final String status;
  final String referralDate;

  Referral({
    required this.id,
    required this.referredName,
    required this.status,
    required this.referralDate,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      referredName: json['referred_name'],
      status: json['status'],
      referralDate: json['referral_date'],
    );
  }
}
