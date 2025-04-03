import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/profile_item.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive padding
          vertical: screenHeight * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
             SizedBox(height: screenHeight * 0.06),

              // Profile Image
              Center(
                child: Column(
                  children: [
                    Container(
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
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: screenWidth * 0.035, // Responsive font size
                      ),
                    ),
                    Text(
                      "Jaydon Bator",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Menu Items
              ProfileMenuItem(
                  title: "Edit Profile",
                  onTap: () {
                    Get.toNamed(RouteName.updateProfile);
                  }),
              ProfileMenuItem(
                  title: "Change Password",
                  onTap: () {
                    Get.toNamed(RouteName.changePassword);
                  }),
              ProfileMenuItem(
                  title: "FAQs",
                  onTap: () {
                    Get.toNamed(RouteName.fAQScreen);
                  }),
              ProfileMenuItem(
                  title: "Terms & Privacy Policy",
                  onTap: () {
                    Get.toNamed(RouteName.termsAndPrivacyScreen);
                  }),
              ProfileMenuItem(title: "Help & Support", onTap: () {
                
                    Get.toNamed(RouteName.emailSupportScreen);
              }),
              ProfileMenuItem(title: "Logout", onTap: () {}),
             
              SizedBox(height: screenHeight * 0.02),
   IconWidget(screenHeight: screenHeight)
            ],
          ),
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
     decoration: BoxDecoration(
       shape: BoxShape.circle,
       border: Border.all(
         
         color: Color.fromARGB(255, 39, 87, 43), // Your desired border color
         width: 2.0, // Border width
       ),
     ),
     child: GestureDetector(
        onTap: () {
          showContactBottomSheet(context);
        },
       child: CircleAvatar(
         radius: screenHeight * 0.035, // Responsive radius
         backgroundColor: AppColors.grey,
         child: Image.asset(AppImages.appIcon),
       ),
     ),
      ),
    );
  }
}




void showContactBottomSheet(BuildContext context) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black, // Dark background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color:AppColors.primaryColor, // Green accent like the image
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: SvgPicture.asset(
              AppImages.message,
            ),
            title: const Text(
              'Message',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle message action
       Get.toNamed(RouteName.chatScreen);
            },
          ),
          Divider(color: AppColors.grey),
          ListTile(
            leading: SvgPicture.asset(
              AppImages.email,
            ),
            title: const Text(
              'Email',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle email action
         
            },
          ),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Ensures smooth transition
  );
}
