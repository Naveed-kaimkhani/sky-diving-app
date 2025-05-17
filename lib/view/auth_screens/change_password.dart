import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/auth_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class ChangePassword extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.put(AuthController());
  TextEditingController passwrodcontroller = TextEditingController();
  TextEditingController confirmpasswrodcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.toNamed(RouteName.forgetPassword),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06), // 6% of screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            Text(
              "Change Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.03, // 3% of screen height
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // 1% of screen height

            // Subtitle
            Text(
              "Please enter New password",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.02, // 2% of screen height
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height

            // Input Fields
            CustomTextField(
              hintText: "Password",
              obscureText: true,
              controller: passwrodcontroller,
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            CustomTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: confirmpasswrodcontroller,
            ),

            // Spacer to push the button to the bottom
            Expanded(child: SizedBox.shrink()),

            // Continue Button
            AuthButton(
              buttonText: "Continue",
              onPressed: () {
                if (passwrodcontroller.text.isEmpty ||
                    confirmpasswrodcontroller.text.isEmpty) {
                  Get.snackbar("Error", "Password is empty",
                      colorText: Colors.white);
                } else if (passwrodcontroller.text !=
                    confirmpasswrodcontroller.text) {
                  Get.snackbar("Error", "Passwords do not match",
                      colorText: Colors.white);
                } else if (passwrodcontroller.text.length < 6) {
                  Get.snackbar("Error", "Passwords must be 6 character long",
                      colorText: Colors.white);
                } else {
                  authController.checkPhoneNumber(
                      authController.phoneNumber.value,

                      // "+923103443527",
                      userController.token.value,
                      passwrodcontroller.text);
                }
              },
              isLoading: authController.isLoading,
            ),
            SizedBox(height: screenHeight * 0.06), // 4% of screen height
          ],
        ),
      ),
    );
  }
}
