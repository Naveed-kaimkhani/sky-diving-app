import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/pincode_field.dart';
import 'package:sky_diving/components/resend_button.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/view_model/auth_controller.dart';

class OTPScreen extends StatelessWidget {
  final TextEditingController otpControllerField = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  // final AuthController authController = Get.put(AuthController());

  final String verificationId = Get.arguments ?? "";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    log(verificationId.toString());
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
              "Please enter the 6-digit code we have sent you on your phone ${authController.phoneNumber.value}",
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
                final otp = otpControllerField.text.trim();
                if (otp.length == 6) {
                  authController.verifyOtp(
                    verificationId: verificationId,
                    otpCode: otp,
                    // onSuccess: () => Get.toNamed(RouteName.bottomNavigation),
                    onSuccess: () {
                      authController.registerUser(
                        user: UserModel(
                          name: authController.nameController.text,
                          email: authController.emailController.text,
                          password: authController.passwordController.text,
                          phone: authController.phoneNumber.value,
                          refId: authController.referralCode
                              .value, // you can fill this after OTP
                        ),
                      );
                    },

                    onError: (message) =>
                        Get.snackbar("Error", message, colorText: Colors.white),
                  );
                } else {
                  Get.snackbar("Invalid OTP", "Please enter a 6-digit OTP",
                      colorText: Colors.white);
                }
              },
              isLoading: authController.isLoading,
            ),

            SizedBox(height: screenSize.height * 0.04),
          ],
        ),
      ),
    );
  }
}

