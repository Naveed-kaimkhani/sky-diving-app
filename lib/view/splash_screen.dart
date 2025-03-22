import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(child: SizedBox()), // Pushes content down

            SvgPicture.asset(
              AppSvgIcons.text,
              width: screenSize.width * 0.75,
              height: screenSize.height * 0.12,
            ),

            SizedBox(height: screenSize.height * 0.06),

            AuthButton(
              buttonText: "Get Started",
              onPressed: () {
                  Get.toNamed(RouteName.login);
              },
              isLoading: false.obs,
            ),

            SizedBox(height: screenSize.height * 0.07), // Bottom spacing
          ],
        ),
      ),
    );
  }
}
