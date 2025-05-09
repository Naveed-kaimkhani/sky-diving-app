import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/services/auth_respository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = Get.find<AuthRepository>();
  // final AuthRepository _authRepo = Get.put(AuthRepository());
  FirebaseAuth _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();

  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var phoneNumber = ''.obs;
  var referralCode = ''.obs;
  RxBool isLoading = false.obs;

  // void sendOtp(String phoneNumber) {
  //   isLoading.value = true;

  //   _authRepo.sendOtp(
  //     phoneNumber: phoneNumber,
  //     onCodeSent: (verificationId) {
  //       isLoading.value = false;
  //       Get.toNamed(RouteName.oTPScreen, arguments: verificationId);
  //     },
  //     onFailed: (e) {
  //       isLoading.value = false;
  //       Get.snackbar("Error", e.message ?? "OTP failed",
  //           colorText: Colors.white);
  //     },
  //   );
  // }
  void sendOtp(String phoneNumber, {required bool isComingFromForgetPassword}) {
    isLoading.value = true;

    _authRepo.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        isLoading.value = false;
        Get.toNamed(
          RouteName.oTPScreen,
          arguments: {
            'verificationId': verificationId,
            'isComingFromForgetPassword': isComingFromForgetPassword,
          },
        );
      },
      onFailed: (e) {
        isLoading.value = false;
        Get.snackbar("Error", e.message ?? "OTP failed",
            colorText: Colors.white);
      },
    );
  }

  Future<void> checkPhoneNumber(
      String phone, String token, String newPassword) async {
    if (phone.isEmpty) {
      Get.snackbar("Error", "Phone number is required",
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final result = await _authRepo.checkPhoneNumber(
        newPassword: newPassword,
        phoneNumber: phone,
        token: token,
      );

      if (result["success"]) {
        int userId = result["data"]["user_id"] as int;
        await _authRepo.changePassword(
          newPassword: newPassword,
          userId: userId,
        );
        // Get.snackbar("Success", "Password changed successfully",
        //     colorText: Colors.white);
        // Get.toNamed(RouteName.login);
      } else {
        final errorMsg = result["data"]["message"] ?? "Something went wrong";
        Get.snackbar("Error", errorMsg, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "An unexpected error occurred",
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void resendOtp(String phoneNumber) {
    isLoading.value = true;

    _authRepo.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        isLoading.value = false;
        Get.snackbar("OTP", "OTP resent successfully!",
            colorText: Colors.white);
      },
      onFailed: (e) {
        isLoading.value = false;
        Get.snackbar("Error", e.message ?? "OTP failed",
            colorText: Colors.white);
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
      isLoading.value = true;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      await _auth.signInWithCredential(credential);
      onSuccess();
    } catch (e) {
      isLoading.value = false;

      onError("OTP verification failed. Please try again.");
    }
  }

  // auth_controller.dart
  void registerUser({required UserModel user}) {
    isLoading.value = true;

    _authRepo.registerUser(
      user: user,
      onSuccess: () {
        isLoading.value = false;
        Get.snackbar("Success", "Registered successfully",
            colorText: Colors.white);
        Get.offAllNamed(
            RouteName.bottomNavigation); // Navigate or trigger OTP logic
      },
      onError: (message) {
        isLoading.value = false;
        Get.snackbar("Error", message, colorText: Colors.white);
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
        Get.snackbar("Success", "Login successful", colorText: Colors.white);
        Get.offAllNamed(RouteName
            .bottomNavigation); // Navigate to home or dashboard after login
      },
      onError: (message) {
        isLoading.value = false;
        Get.snackbar("Error", message, colorText: Colors.white);
      },
    );
  }

  void forgotPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your phone number",
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await _authRepo.forgotPassword(
        email: email,
        onSuccess: () {
          isLoading.value = false;
          Get.snackbar("Success", "Password reset email sent",
              colorText: Colors.white);
        },
        onError: (message) => Get.snackbar("Error", message),
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.message ?? "Failed to send reset email",
          colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong", colorText: Colors.white);
    }
  }

  void deleteUser(int userId) {
    // log(userId.toString());
    _authRepo.deleteUser(
      userId: userId,
      onSuccess: () {
        isLoading.value = false;
        Get.back(); // Instead of Navigator.pop
        Get.offAllNamed(RouteName.login);
        // isDeleting.value = false;

        Get.snackbar("Success", "User deleted successfully",
            colorText: Colors.white);
        // Navigate or update UI after deletion
      },
      onError: (message) {
        isLoading.value = false;
        Get.snackbar("Error", message, colorText: Colors.white);
      },
    );
  }
}
