import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  final otpController = TextEditingController();
  final _secondsRemaining = 96.obs;
  final _isResendActive = false.obs;
  Timer? _timer;

  int get secondsRemaining => _secondsRemaining.value;
  bool get isResendActive => _isResendActive.value;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _isResendActive.value = true;
        timer.cancel();
      }
    });
  }

  void resendCode() {
    _secondsRemaining.value = 96;
    _isResendActive.value = false;
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}