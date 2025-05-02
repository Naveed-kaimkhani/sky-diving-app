import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/services/auth_respository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = Get.find<AuthRepository>();
  // final AuthRepository _authRepo = Get.put(AuthRepository());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
var phoneNumber = ''.obs;
var referralCode = ''.obs; 
  RxBool isLoading = false.obs;

  void sendOtp(String phoneNumber) {
    isLoading.value = true;

    _authRepo.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        isLoading.value = false;
        log(verificationId);
        Get.toNamed(RouteName.oTPScreen, arguments: verificationId);
      },
      onFailed: (e) {
        isLoading.value = false;
        log(e.toString());
        Get.snackbar("Error", e.message ?? "OTP failed",colorText: Colors.white);
      },
    );
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String otpCode,
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      PhoneAuthCredential credential =  PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      log("credential $credential");
      // await _auth.signInWithCredential(credential);
      onSuccess();
    } catch (e) {
      log("OTP verification error: $e");
      onError("OTP verification failed. Please try again.");
    }
  }


  // auth_controller.dart
void registerUser({
required UserModel user

}) {
  isLoading.value = true;

  _authRepo.registerUser(
    user:user,
    onSuccess: () {
      isLoading.value = false;
      Get.snackbar("Success", "Registered successfully",colorText: Colors.white);
      Get.toNamed(RouteName.bottomNavigation); // Navigate or trigger OTP logic
    },
    onError: (message) {
      isLoading.value = false;
      Get.snackbar("Error", message,colorText: Colors.white);
    },
  );
}

// auth_controller.dart
void loginUser({
  required String email,
  required String password,
}) {
  isLoading.value = true;

  _authRepo.loginUser(
    email: email,
    password: password,
    onSuccess: () {
      isLoading.value = false;
      Get.snackbar("Success", "Login successful",colorText: Colors.white);
      Get.offAllNamed(RouteName.bottomNavigation); // Navigate to home or dashboard after login
    },
    onError: (message) {
      isLoading.value = false;
      Get.snackbar("Error", message,colorText: Colors.white);
    },
  );
}


}
