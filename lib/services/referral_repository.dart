import 'dart:convert';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';

class ReferralRepository {
  final ApiClient apiClient = Get.find<ApiClient>();
  Future<ReferralData?> fetchReferralData() async {
    try {
      final response = await apiClient.get(
        url: ApiEndpoints.referral,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          return ReferralData.fromJson(data);
        }
      }
    } catch (e) {
      print('Referral fetch error: $e');
      Get.snackbar("Error", "Failed to fetch referral");
    }
    return null;
  }
}
