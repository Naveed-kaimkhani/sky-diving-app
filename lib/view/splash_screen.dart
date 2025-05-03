import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/navigation_bar.dart';
import 'package:sky_diving/view_model/referral_controller.dart';

import '../view_model/user_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final UserController userController = Get.put(UserController());

  void _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2));
    await userController.getUserFromPrefs();

    if (userController.token.value.isNotEmpty) {
      Get.put(ReferralController()); // 👈 Inject here

      // Get.offAll(() => BottomNavigation());
      Get.offAllNamed(RouteName.bottomNavigation);
    }
    // else: showGetStarted becomes true inside the controller
  }

  @override
  Widget build(BuildContext context) {
    _checkAuthentication();

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
            const Expanded(child: SizedBox()),
            SvgPicture.asset(
              AppSvgIcons.text,
              width: screenSize.width * 0.75,
              height: screenSize.height * 0.12,
            ),
            SizedBox(height: screenSize.height * 0.06),
            Obx(() => userController.showGetStarted.value
                ? AuthButton(
                    buttonText: "Get Started",
                    onPressed: () => Get.toNamed(RouteName.login),
                    isLoading: false.obs,
                  )
                : const SizedBox()),
            SizedBox(height: screenSize.height * 0.07),
          ],
        ),
      ),
    );
  }
}
