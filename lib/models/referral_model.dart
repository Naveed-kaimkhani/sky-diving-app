class Referral {
  final int id;
  final String? referredName;
  final String status;
  final String referralDate;


  final String totalPoints;

  final String avatarUrl;

  Referral({
    required this.id,
    required this.referredName,
    required this.status,
    required this.avatarUrl,
    required this.totalPoints,
    required this.referralDate,

  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      totalPoints: json['referred_total_points'],

      avatarUrl: json['avatar_url'],
      referredName: json['referred_name'],
      status: json['status'],
      referralDate: json['referral_date'],
    );
  }
}
