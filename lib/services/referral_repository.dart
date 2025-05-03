import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
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
}
