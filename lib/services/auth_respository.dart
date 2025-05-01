import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/api_endpoints.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class AuthRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  final UserController userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
// auth_repository.dart
// Future<void> registerUser({
//   required String name,
//   required String email,
//   required String phoneNumber,
//   required String password,
//   required VoidCallback onSuccess,
//   required Function(String message) onError,
// }) async {
//   try {
//     final response = await apiClient.post(
//      url:  ApiEndpoints.register,
      
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       onSuccess();
//     } else {
//       onError(response.body['message'] ?? 'Registration failed');
//     }
//   } catch (e) {
//     log("Register error: $e");
//     onError("An error occurred during registration.");
//   }
// }


  Future<void> registerUser({
    // required String name,
    // required String email,
    // required String phoneNumber,
    // required String password,
    required UserModel user,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    // final fullUrl = "${baseUrl}register";

    try {
      final response = await apiClient.post(
        url: ApiEndpoints.register,
        headers: {"Content-Type": "application/json"},
        // body: {
        //   "name": name,
        //   "email": email,
        //   "phone_number": phoneNumber,
        //   "password": password,
        // },
        body: user.toJson()
      );

      log("Register Response: ${response.statusCode} => ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      } else {
        onError("Registration failed: ${response.body}");
      }
    } catch (e) {
      log("Register error: $e");
      onError("An error occurred during registration.");
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
}
