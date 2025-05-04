import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/models/user_reward_model.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';

class ReferralRepository {
  final ApiClient apiClient = Get.find<ApiClient>();
  Future<ReferralData?> fetchReferralData(String token) async {
    try {
      log("token value $token");
      final response = await apiClient.get(
        url: ApiEndpoints.referral,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // optional, but recommended
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        log("data fetched again");
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
      log("token value $token");
      final response = await apiClient.get(
        url: ApiEndpoints.userReward,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // optional, but recommended
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        log("data fetched again");
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


  // Future<UserRewardResponse?> getUserRewards(String token) async {
  //   try {
  //     final response = await apiClient.get(
  //       url: 'https://deinfini.com/info/public/api/user-reward',
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // First check if body is already a Map (some API clients auto-parse JSON)
  //       if (response.body is Map) {
  //         if (response.body['success'] == true) {
  //           return UserRewardResponse.fromJson(response.body);
  //         }
  //       } 
  //       // If body is String, parse it first
  //       else if (response.body is String) {
  //         final data = jsonDecode(response.body);
  //         if (data['success'] == true) {
  //           return UserRewardResponse.fromJson(data);
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to fetch rewards",
  //         colorText: Colors.white);
  //     print('Error fetching rewards: $e');
  //   }
  //   return null;
  // }
}
