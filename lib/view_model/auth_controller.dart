import 'dart:developer';

import 'package:get/get.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/services/auth_respository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = Get.find<AuthRepository>();

  RxBool isLoading = false.obs;

  void sendOtp(String phoneNumber) {
    isLoading.value = true;

    _authRepo.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        isLoading.value = false;
        log(verificationId);
        // Get.toNamed(RouteName.oTPScreen, arguments: verificationId);
      },
      onFailed: (e) {
        isLoading.value = false;
        Get.snackbar("Error", e.message ?? "OTP failed");
      },
    );
  }
}
