import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/services/referral_repository.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class ReferralController extends GetxController {
  final ReferralRepository repository = Get.find<ReferralRepository>();
  final RxBool isRedeeming = false.obs;

  final UserController userController = Get.find<UserController>();

  Rxn<ReferralData> referralData = Rxn<ReferralData>(); // nullable Rx

  Future<void> fetchReferralData() async {
    final data = await repository.fetchReferralData(userController.token.value);
    if (data != null) {
      referralData.value = data;
    }
  }

  Future<void> redeemUserPoints(int points, String token) async {
    isRedeeming.value = true;
    final result = await repository.redeemPoints(token, points);
    isRedeeming.value = false;

    if (result != null && result.success) {
      Get.snackbar("Success", result.message, colorText: Colors.white);
    } else {
      Get.snackbar("Error", result?.message ?? "Redemption failed",
          colorText: Colors.white);
    }
  }
}
