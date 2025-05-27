import 'package:intl/intl.dart';

class UserPoints {
  final int userId;
  final int redeemPoints;
  final String status;
  final DateTime createdAt;

  UserPoints({
    required this.userId,
    required this.redeemPoints,
    required this.status,
    required this.createdAt,
  });

  factory UserPoints.fromJson(Map<String, dynamic> json) {
    return UserPoints(
      userId: json['user_id'],
      redeemPoints: json['redeem_points'],
      status: json['status'],
      // createdAt: json['created_at'],
      // createdAt: DateFormat().parse(json['created_at']),
      createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS'Z'")
              .parseUtc(json['created_at'])
              .toLocal(),
    );
  }
}
