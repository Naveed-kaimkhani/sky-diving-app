// user_reward_model.dart
import 'dart:developer';

class UserReward {
  final int id;
  final String couponCode;
  final String status;
  final DateTime expiryDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final dynamic points;
  final dynamic discount;
  final dynamic couponValue;

  UserReward({
    required this.id,
    required this.couponCode,
    required this.userId,
    required this.points,
    required this.discount,
    required this.couponValue,
    required this.status,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserReward.fromJson(Map<String, dynamic> json) {
    return UserReward(
      id: json['id'],
      couponCode: json['coupon_code'].toString(),
      userId: json['user_id'],
      points: json['points'],
      discount: json['discount'],
      couponValue: json['coupon_value'],
      status: json['status'].toString(),
      expiryDate: DateTime.parse(json['expiry_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class UserRewardResponse {
  final bool success;
  final List<UserReward> data;

  UserRewardResponse({
    required this.success,
    required this.data,
  });

  factory UserRewardResponse.fromJson(Map<String, dynamic> json) {
    
    return UserRewardResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((reward) => UserReward.fromJson(reward))
          .toList(),
    );
  }
}
