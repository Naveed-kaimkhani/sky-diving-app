import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Update Profile",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive padding
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.08),

            // Profile Image
            Stack(
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.24, // Responsive width
                    height: screenWidth * 0.24, // Responsive height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppSvgIcons.profile, // Replace with actual image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 60,
                    left: 200,
                    child: Container(
                      height: screenWidth * 0.08, // Adaptive size
                      width: screenWidth * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: screenWidth * 0.06,
                      ),
                    ))
              ],
            ),

            SizedBox(height: screenHeight * 0.05),

            CustomTextField(hintText: userController.user.value!.name),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                hintText: userController.user.value!.email, obscureText: true),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
                hintText: userController.user.value!.phone, obscureText: true),
            SizedBox(height: screenHeight * 0.04),
            AuthButton(
              buttonText: "Update",
              onPressed: () {
              },
              isLoading: false.obs,
            ),
          ],
        ),
      ),
    );
  }
}
