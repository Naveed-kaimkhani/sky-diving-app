import 'package:sky_diving/models/referral_model.dart';

class ReferralData {
  final int totalReferrals;
  final int activeReferrals;
  final int earnedPoints;
  final List<Referral> referrals;

  ReferralData({
    required this.totalReferrals,
    required this.activeReferrals,
    required this.earnedPoints,
    required this.referrals,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      totalReferrals: json['total_referrals'] ?? 0,
      activeReferrals: json['active_referrals'] ?? 0,
      earnedPoints: json['earned_points'] ?? 0,
      referrals: (json['referrals'] as List<dynamic>?)
              ?.map((item) => Referral.fromJson(item))
              .toList() ??
          [],
    );
  }
}
