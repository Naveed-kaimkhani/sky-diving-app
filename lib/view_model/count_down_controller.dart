import 'dart:async';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  var timeLeft = 60.obs; // Start countdown from 60 seconds
  late Timer _timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel(); // Stop timer when it reaches zero
      }
    });
  }

  void resetTimer() {
    timeLeft.value = 60; // Reset to 60 seconds
    startTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
