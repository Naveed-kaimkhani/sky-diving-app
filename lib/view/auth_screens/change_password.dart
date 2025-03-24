import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/view/home/home_screen.dart';

class ChangePassword extends StatelessWidget {
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
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.white),
      ),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // 6% of screen width
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
            CustomTextField(hintText: "Password"),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            CustomTextField(hintText: "Confirm Password"),

            // Spacer to push the button to the bottom
            Expanded(child: SizedBox.shrink()),

            // Continue Button
            AuthButton(
              buttonText: "Continue",
              onPressed: () {
                Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
);

              },
              isLoading: false.obs,
            ),
            SizedBox(height: screenHeight * 0.05), // 4% of screen height
          ],
        ),
      ),
    );
  }
}