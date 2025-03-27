

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';

class QrCode extends StatelessWidget {
  const QrCode({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final shortestSide = screenSize.shortestSide;
    
    // Define breakpoints for different screen sizes
    final bool isSmallScreen = shortestSide < 400;
    final bool isMediumScreen = shortestSide >= 400 && shortestSide < 600;
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: "Jaydon Bator", 
        profileImage: AppSvgIcons.profile
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16.0 : 
                       isMediumScreen ? 24.0 : 32.0,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenSize.height - 
                          MediaQuery.of(context).padding.top - 
                          kToolbarHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelText(
                            text: "Your Unique Referral Code", 
                            fontSize: isSmallScreen ? 16 : 18,
                          ),
                          LabelText(
                            text: "Scan QR", 
                            fontSize: isSmallScreen ? 12 : 14,
                            textColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Container(
                        width: shortestSide * 0.8, // Responsive QR size
                        height: shortestSide * 0.8,
                        child: Image.asset(
                          AppImages.qr,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: isSmallScreen ? 16.0 : 24.0,
                      top: screenSize.height * 0.035,
                    ),
                    child: AuthButton(
                      buttonText: "Share QR Code", 
                      onPressed: (){
                        Get.toNamed(RouteName.referralHistory);
                      }, 
                      isLoading: false.obs,
                      // width: screenSize.width * 0.9, // Responsive button width
                    ),
                  ),
                  
                      SizedBox(height: screenSize.height * 0.3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}