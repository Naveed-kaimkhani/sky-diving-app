import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/utils/utils.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import '../view_model/user_controller.dart';
import '../view_model/user_reward_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.put(UserController());

  void _checkAuthentication() async {
     bool isConnected = await Utils.checkInternetConnection();
  if (!isConnected) return;

    await userController.getUserFromPrefs();

    if (userController.token.value.isNotEmpty) {
      final referralController = Get.put(ReferralController(), permanent: true);
      await referralController.fetchReferralData();

      final UserRewardController _controller =
          Get.put(UserRewardController(), permanent: true);
      await _controller.fetchUserRewards(userController.token.value);
      Get.offAllNamed(RouteName.bottomNavigation);
    }
  }
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//   ReferralServices.initDynamicLinks();
//   }
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

                    // onPressed: () => ReferralServices.createReferralLink("-kfjsdlfj"),
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
