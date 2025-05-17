import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

import 'package:http/http.dart' as http;

class AuthRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  final UserController userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerUser({
    required UserModel user,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final response =
          await apiClient.post(url: ApiEndpoints.register, body: user.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userData = responseData['user'];
        final user = UserModel.fromJson(userData);
        await userController.saveUserSessionFromResponse(user, token);

        await userController.getUserFromPrefs();
        final referralController =
            Get.put(ReferralController(), permanent: true);
        await referralController.fetchReferralData();
        final UserRewardController _controller =
            Get.put(UserRewardController(), permanent: true);
        await _controller.fetchUserRewards(userController.token.value);
        onSuccess();
      } else {
        final error = jsonDecode(response.body);
        onError(error['message'] ?? 'Registration failed');
      }
    } catch (e) {
      onError("An error occurred during registration $e.");
    }
  }

  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException) onFailed,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        Get.snackbar("Success", "$credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // auth_repository.dart
  Future<void> loginUser({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final response = await apiClient.post(
        url: ApiEndpoints.login,
        body: {
          'email': email,
          'password': password,
        },
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userData = responseData['user'];
        final user = UserModel.fromJson(userData);
        await userController.saveUserSessionFromResponse(user, token);
        await userController.getUserFromPrefs();

        final referralController =
            Get.put(ReferralController(), permanent: true);
       
        await referralController.fetchReferralData();
        final UserRewardController _controller =
            Get.put(UserRewardController(), permanent: true);
        await _controller.fetchUserRewards(userController.token.value);


        onSuccess(); // Trigger on success callback
      } else {

        final error = jsonDecode(response.body);
        onError(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      onError("An error occurred during login.");
    }
  }

  Future<void> forgotPassword({
    required String email,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      // await _auth.sendPasswordResetEmail(email: email);
      await apiClient.post(url: ApiEndpoints.forgetPassword, body: {
        "email": email,
      });
      onSuccess();
    } on Exception catch (e) {
      onError("Failed to send password reset email.");
    } catch (e) {
      onError("Something went wrong. Please try again.");
    }
  }

  Future<void> deleteUser({
    required dynamic userId,
    required String token,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.delete),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // <-- Add this line
        },
        body: jsonEncode({
          "user_id": userId, // convert to string to avoid type error
        }),
      );


      if (response.statusCode == 200) {
        onSuccess();
      } else {
        final data = jsonDecode(response.body);
        onError(data["message"] ?? "Failed to delete user.");
      }
    } catch (e) {
      onError("An error occurred while deleting the user.");
    }
  }

  Future<Map<String, dynamic>> checkPhoneNumber({
    required String phoneNumber,
    required String token,
    required String newPassword,
  }) async {
    final response = await apiClient.post(
      url: ApiEndpoints.validatePhone,
      body: {
        "phone_number": phoneNumber,
      },
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {"success": true, "data": data};
    } else {
      return {"success": false, "data": data};
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String newPassword,
    required int userId,
  }) async {
    try {

      final response = await http.post(
        Uri.parse(ApiEndpoints.changePassword),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "password": newPassword,
          "password_confirmation": newPassword
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password changed successfully",
            colorText: Colors.white);
        Get.toNamed(RouteName.login);
        return {"success": true, "data": data};
      } else {
        return {"success": false, "data": data};
      }
    } catch (e) {
      return {
        "success": false,
        "data": {"message": "An error occurred"}
      };
    }
  }
}
