import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/redeem_response_model.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/models/user_reward_model.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';

class ReferralRepository {
  final ApiClient apiClient = Get.find<ApiClient>();
  Future<ReferralData?> fetchReferralData(String token) async {
    try {
      final response = await apiClient.get(
        url: ApiEndpoints.referral,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // optional, but recommended
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          return ReferralData.fromJson(data);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch referral",
          colorText: Colors.white);
    }
    return null;
  }

  Future<UserRewardResponse?> getUserRewards(String token) async {
    try {
      final response = await apiClient.get(
        url: ApiEndpoints.userReward,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return UserRewardResponse.fromJson(data);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch referral",
          colorText: Colors.white);
    }
    return null;
  }

  Future<RedeemResponse?> redeemPoints(String token, int points) async {
    try {
      final response = await apiClient.sendMessageAPI(
        url: ApiEndpoints.redeemPoints,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"redeem_points": points}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RedeemResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar("Error", errorData['message'] ?? "Redemption failed",
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Redeem failed: $e", colorText: Colors.white);
    }
    return null;
  }
}
