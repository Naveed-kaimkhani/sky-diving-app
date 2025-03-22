import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/resend_button.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/routes_name.dart';

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

class OTPScreen extends StatelessWidget {
  final TextEditingController otpControllerField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.02),
            Text(
              "Verification code",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.015),
            Text(
              "Please enter the 6-digit code we have sent you on your phone +123 456789",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.04,
              ),
            ),
            SizedBox(height: screenSize.height * 0.08),

            Center(child: PinCodeField(otpControllerField: otpControllerField)),

            Expanded(child: SizedBox()), // Pushes buttons to the bottom

            Center(child: ResendButton()),
            SizedBox(height: screenSize.height * 0.02),

            AuthButton(
              buttonText: "Continue",
              onPressed: () {
                Get.toNamed(RouteName.changePassword);
              },
              isLoading: false.obs,
            ),

            SizedBox(height: screenSize.height * 0.04),
          ],
        ),
      ),
    );
  }
}

class PinCodeField extends StatelessWidget {
  const PinCodeField({
    super.key,
    required this.otpControllerField,
  });

  final TextEditingController otpControllerField;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PinCodeTextField(
      length: 6,
      controller: otpControllerField,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: screenSize.height * 0.06,
        fieldWidth: screenSize.width * 0.12,
        inactiveFillColor: const Color.fromARGB(255, 26, 25, 25),
        inactiveColor: Colors.transparent,
        selectedFillColor: Color(0xFF161622),
        selectedColor: AppColors.primaryColor,
        activeFillColor: AppColors.primaryColor,
        activeColor: Colors.black,
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: screenSize.width * 0.06,
        fontWeight: FontWeight.bold,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      appContext: context,
    );
  }
}
