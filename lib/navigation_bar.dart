import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/view/QRCode_screen/referral_history.dart';
import 'package:sky_diving/view/QRCode_screen/reward_screen.dart';
import 'package:sky_diving/view/home/home_screen.dart';
import 'package:sky_diving/view/profile_screens/profile.dart';
import 'package:sky_diving/view_model/bottom_navigation_controller.dart';

class BottomNavigation extends StatelessWidget {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  // List of pages
  List<Widget> _widgetOptions() {
    return [
      HomeScreen(),
      RewardScreen(),
      ReferralHistory(),
      ProfileScreen(),
    ];
  }

  // List of icons
  List<IconData> iconList = [
    Icons.home_filled,
    Icons.emoji_events,
    Icons.group,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.075;
    final fabSize = screenSize.width * 0.15;
    final svgIconSize = screenSize.width * 0.07;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => IndexedStack(
            index: controller.bottomNavIndex.value,
            children: _widgetOptions(),
          )),
      floatingActionButton: Container(
        height: fabSize,
        width: fabSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Get.toNamed(RouteName.changePassword);
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            AppImages.scan,
            height: svgIconSize,
            width: svgIconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: controller.bottomNavIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: controller.changeIndex,
            backgroundColor: AppColors.grey,
            activeColor: AppColors.primaryColor,
            inactiveColor: Colors.grey[600],
            splashColor: Colors.black,
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
            ),
            iconSize: iconSize,
          )),
    );
  }
}
