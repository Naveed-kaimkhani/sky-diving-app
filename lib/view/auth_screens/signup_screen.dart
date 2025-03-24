import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/phone_number_field.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/routes_name.dart';
import '../../constants/app_images.dart';
import '../../constants/app_svg_icons.dart';

class SignupScreen extends StatelessWidget {
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
                
                CustomTextField(hintText: "Full Name"),
                SizedBox(height: screenSize.height * 0.02),
                CustomTextField(hintText: "Email Address"),
                SizedBox(height: screenSize.height * 0.02),
                PhoneNumberField(),
                SizedBox(height: screenSize.height * 0.015),
                CustomTextField(hintText: "Password", obscureText: true),
                SizedBox(height: screenSize.height * 0.02),
                CustomTextField(hintText: "Confirm Password", obscureText: true),
            
                      SizedBox(height: screenSize.height * 0.03),
                AuthButton(buttonText: "Register", onPressed: () {
                  Get.toNamed(RouteName.oTPScreen);
                }, isLoading: false.obs),
                // SizedBox(height: screenSize.height * 0.02),
                SizedBox(height: screenSize.height * 0.02),
                ScanQRCodeButton(buttonWidth: buttonWidth, buttonHeight: buttonHeight, screenSize: screenSize),
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

class ScanQRCodeButton extends StatelessWidget {
  const ScanQRCodeButton({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.screenSize,
  });

  final double buttonWidth;
  final double buttonHeight;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 26, 25, 25),
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.015,
            horizontal: screenSize.width * 0.04,
          ),
               shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              // side: BorderSide(color: Colors.grey.shade300), // Optional: Add a border if needed
            ),
        ),
        onPressed: () {},
        child: Text(
          "Scan QR Code",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenSize.width * 0.05,
          ),
        ),
      ),
    );
  }
}
