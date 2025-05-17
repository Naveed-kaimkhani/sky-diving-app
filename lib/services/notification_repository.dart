import 'dart:convert';
import 'dart:developer';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';

class NotificationRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<dynamic>> fetchNotifications(String token) async {
    final response = await _apiClient.get(
      url: ApiEndpoints.notification,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // Adjust this if the structure is different
    } else {
      throw Exception("Failed to load notifications: ${response.statusCode}");
    }
  }
}
