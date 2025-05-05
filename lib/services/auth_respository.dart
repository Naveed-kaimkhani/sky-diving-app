import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class AuthRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  final UserController userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
// Future<UserCredential?> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   if (googleUser == null) return null;

//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
  // final AuthController authController = Get.put(AuthController());
  Future<void> registerUser({
    required UserModel user,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    // final fullUrl = "${baseUrl}register";
    log("in register user");
    try {
      log(user.toJson().toString());
      // log(user.toJson(authController.referralCode.value).toString());
      final response = await apiClient.post(
          url: ApiEndpoints.register,
          // headers: {"Content-Type": "application/json"},
          body: user.toJson());
      // log(user.toJson().toString());
      log(response.body);
      log(response.statusCode.toString());
      log("Register Response: ${response.statusCode} => ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
    
// final referralController = Get.put(ReferralController(), permanent: true);
    final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userData = responseData['user'];
        final user = UserModel.fromJson(userData);
        await userController.saveUserSessionFromResponse(user, token);

        await userController.getUserFromPrefs();

        Get.put(ReferralController());
        onSuccess();
      } else {
        final error = jsonDecode(response.body);
        onError(error['message'] ?? 'Registration failed');
      }
    } catch (e) {
      log("Register error: $e");
      // onError("An error occurred during registration.");

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
        // Auto-retrieval or instant verification
        print("Verification completed: $credential");
        Get.snackbar("Success", "$credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed(e);
        log(e.toString());
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
      log("in login user");
      final response = await apiClient.post(
        url: ApiEndpoints.login,
        body: {
          'email': email,
          'password': password,
        },
      );

      log("Login Response: ${response.statusCode} => ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userData = responseData['user'];
        final user = UserModel.fromJson(userData);

        // Save the session using the userController
        await userController.saveUserSessionFromResponse(user, token);
        await userController.getUserFromPrefs();

final referralController = Get.put(ReferralController(), permanent: true);
        await referralController.fetchReferralData();

        onSuccess(); // Trigger on success callback
      } else {
        final error = jsonDecode(response.body);
        onError(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      log("Login error: $e");
      onError("An error occurred during login.");
    }
  }
}


