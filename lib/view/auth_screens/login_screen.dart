import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/auth_controller.dart';
import '../../constants/app_images.dart';
import '../../constants/app_svg_icons.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  bool _validateFields() {
    if (authController.emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter email",
        colorText: Colors.white,
      );
      return false;
    }
    if (!EmailValidator.validate(authController.emailController.text.trim())) {
      Get.snackbar(
        "Error",
        "Please enter a valid email",
        colorText: Colors.white,
      );
      return false;
    }
    if (authController.passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter password",
        colorText: Colors.white,
      );
      return false;
    }
    if (authController.passwordController.text.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters",
          colorText: Colors.white);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  SvgPicture.asset(
                    AppSvgIcons.text,
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.1,
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  CustomTextField(
                    hintText: "Email Address",
                    controller: authController.emailController,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: authController.passwordController,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: LabelText(
                        text: "Forgot your password?",
                        textAlign: TextAlign.right,
                        textColor: AppColors.primaryColor,
                      ),
                      onTap: () => Get.toNamed(RouteName.forgetPassword),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  AuthButton(
                    buttonText: "Login",
                    onPressed: () {
                      if (_validateFields()) {
                        FocusScope.of(context).unfocus();
                        authController.loginUser(
                          email: authController.emailController.text.trim(),
                          password:
                              authController.passwordController.text.trim(),
                        );
                      }
                    },
                    isLoading: authController.isLoading,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // SocialLoginButton(
                  //   text: "Login with Apple",
                  //   iconPath: AppImages.apple,
                  //   onPressed: () {},
                  //   buttonColor: const Color.fromARGB(255, 26, 25, 25),
                  //   textColor: Colors.white,
                  // ),
                  // SizedBox(height: screenHeight * 0.03),
                  // SocialLoginButton(
                  //   text: "Login with Google",
                  //   iconPath: AppImages.google,
                  //   onPressed: () {},
                  //   textColor: Colors.black,
                  // ),
                  // SizedBox(height: screenHeight * 0.03),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.signup);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Not a member?",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: " Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
