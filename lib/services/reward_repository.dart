import 'dart:developer';

import 'package:get/get.dart';
import 'package:sky_diving/models/user_rewardedpoints.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'dart:convert';

class RewardRepository {
  final ApiClient _apiClient = Get.find<ApiClient>(); // Dependency Injection

  final UserController userController = Get.find<UserController>();
  Future<List<UserPoints>> fetchUserRewards() async {
    final response = await _apiClient.get(
      url: ApiEndpoints.userPoints,
      headers: {
        'Authorization': 'Bearer ${userController.token.value}',
        'Content-Type': 'application/json', // optional, but recommended
      },
    );
    log("in reward repo");
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        final List rewardsJson = data['redeem_requests'];
        return rewardsJson.map((e) => UserPoints.fromJson(e)).toList();
      } else {
        throw Exception("API returned success: false");
      }
    } else {
      log("exception aai");
      log(response.body);
      throw Exception("Failed to fetch rewards. Code: ${response.statusCode}");
    }
  }
}
