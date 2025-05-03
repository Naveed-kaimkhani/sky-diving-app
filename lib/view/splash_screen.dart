import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/referral_controller.dart';

import '../view_model/user_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final UserController userController = Get.put(UserController());

  void _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 3));
    await userController.getUserFromPrefs();

    if (userController.token.value.isNotEmpty) {
      // Get.put(ReferralController()); // 👈 Inject here
      final referralController = Get.put(ReferralController(),permanent: true);
      // await referralController.fetchReferralData(); // wait for data fetch
    await referralController.fetchReferralData();

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

// class SplashScreen extends StatefulWidget {
//   SplashScreen({Key? key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final UserController userController = Get.put(UserController());

//   final ReferralController referralController = Get.put(ReferralController());

//   @override
//   void initState() {
//     super.initState();
//     _checkAuthentication();
//   }

//   void _checkAuthentication() async {
//     await userController.getUserFromPrefs();

//     if (userController.token.value.isNotEmpty) {
//       await referralController.fetchReferralData();
//       Get.offAllNamed(RouteName.bottomNavigation);
//     } else {
//       userController.showGetStarted.value = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Obx(() {
//         if (userController.token.value.isEmpty) {
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AppImages.splashImg),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               children: [
//                 const Expanded(child: SizedBox()),
//                 SvgPicture.asset(
//                   AppSvgIcons.text,
//                   width: screenSize.width * 0.75,
//                   height: screenSize.height * 0.12,
//                 ),
//                 SizedBox(height: screenSize.height * 0.06),
//                 AuthButton(
//                   buttonText: "Get Started",
//                   onPressed: () => Get.toNamed(RouteName.login),
//                   isLoading: false.obs,
//                 ),
//                 SizedBox(height: screenSize.height * 0.07),
//               ],
//             ),
//           );
//         } else {
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AppImages.splashImg),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               children: [
//                 const Expanded(child: SizedBox()),
//                 SvgPicture.asset(
//                   AppSvgIcons.text,
//                   width: screenSize.width * 0.75,
//                   height: screenSize.height * 0.12,
//                 ),
//                 SizedBox(height: screenSize.height * 0.06),
//                 AuthButton(
//                   buttonText: "Get Started",
//                   onPressed: () => Get.toNamed(RouteName.login),
//                   isLoading: false.obs,
//                 ),
//                 SizedBox(height: screenSize.height * 0.07),
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
