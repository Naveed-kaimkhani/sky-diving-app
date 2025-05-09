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
      log(response.body);
      log("login api hit");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userData = responseData['user'];
        final user = UserModel.fromJson(userData);
        log(user
            .toJson()
            .toString()); // Save the session using the userController
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
      log(e.toString());
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
    required int userId,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      final body = {
        'user_id': userId,
      };
      log("before api hit");
      log(json.encode(body));
      final response = await apiClient.post(
        url: ApiEndpoints.delete,
        body: json.encode(body),
      );
      log(response.body);
      if (response.statusCode == 200) {
        onSuccess(); // Call the success callback
      } else {}
    } catch (e) {
      log(e.toString());
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
    log(response.body);
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
    log("use rid is $userId");
    final response = await apiClient.post(
      url: ApiEndpoints.changePassword,
      body: {
        "user_id": userId,
        "password": newPassword,
      },
    );
    log(response.body);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Password changed successfully",
          colorText: Colors.white);
      Get.toNamed(RouteName.login);
      return {"success": true, "data": data};
    } else {
      return {"success": false, "data": data};
    }
  }
}
