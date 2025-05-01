import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/phone_number_field.dart';
import 'package:sky_diving/components/scan_qr_code_button.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/auth_controller.dart';
import '../../constants/app_images.dart';
import '../../constants/app_svg_icons.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  //  bool _isValidEmail(String email) {
  //   return _validEmailDomains.any((domain) => email.endsWith(domain));
  // }

  // bool _validateFields() {
  //   if (authController.nameController.text.isEmpty) {
  //     // _showValidationError("Name is required", "Please enter your name");
  //     Get.snackbar("Error", "Please enter name");
  //     return false;
  //   }
  //   if (_emailController.text.isEmpty) {
  //     _showValidationError("Email is required", "Please enter your email");
  //     return false;
  //   }
  //   if (_phoneNumberController.text.isNotEmpty &&
  //       _phoneNumberController.text.length > 10) {
  //     _showValidationError("Warning", "Phone Number must be 10 digits");
  //     return false;
  //   }
  
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.058;
    final buttonWidth = screenSize.width * 0.9;

    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.1),
                SvgPicture.asset(
                  AppSvgIcons.text,
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.1,
                ),
                SizedBox(height: screenSize.height * 0.08),
                Text(
                  "Register Yourself",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height * 0.04),

                CustomTextField(
                  hintText: "Full Name",
                  controller: authController.nameController,
                ),
                SizedBox(height: screenSize.height * 0.02),
                CustomTextField(
                  hintText: "Email Address",
                  controller: authController.emailController,
                ),
                SizedBox(height: screenSize.height * 0.02),
                PhoneNumberField(
                  onPhoneChanged: (value) {
                    authController.phoneNumber.value = value;
                  },
                ),
                SizedBox(height: screenSize.height * 0.015),
                CustomTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: authController.passwordController,
                ),
                SizedBox(height: screenSize.height * 0.02),
                CustomTextField(
                    hintText: "Confirm Password",
                    obscureText: true,
                    controller: authController.confirmPasswordController),

                SizedBox(height: screenSize.height * 0.03),
                AuthButton(
                    buttonText: "Register",
                    onPressed: () {
                      String phone = "+923422179919";

                      // String phone = "+19724218407"; // format properly
                      authController.sendOtp(phone);
                    },
                    isLoading: authController.isLoading),
                // SizedBox(height: screenSize.height * 0.02),
                SizedBox(height: screenSize.height * 0.02),
                ScanQRCodeButton(
                    buttonWidth: buttonWidth,
                    buttonHeight: buttonHeight,
                    screenSize: screenSize),
                SizedBox(height: screenSize.height * 0.03),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.login);
                      // Navigate to Log In Page
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: " Login now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
