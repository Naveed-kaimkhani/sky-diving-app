import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_button.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/components/line_chart.dart';
import 'package:sky_diving/components/navigation_button.dart';
import 'package:sky_diving/components/referral_card.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/components/reward_card.dart';
import 'package:sky_diving/components/rewards_tab_bar.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/testt.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: "Jaydon Bator",
        profileImage: AppSvgIcons.profile,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive horizontal padding
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // Reward Balance Card (Responsive)
              RewardBalanceCard(
                height: screenHeight * 0.10, // Adjusted height
                width: screenWidth * 0.52, // Adjusted width
                balance: "\$50.00",
                coinImage: AppSvgIcons.coin,
                confettiImage: AppSvgIcons.confettiImage,
              ),

              SizedBox(height: screenHeight * 0.03),

              LabelText(
                text: "Rewards",
                fontSize: screenWidth * 0.045, // Responsive font size
                weight: FontWeight.bold,
              ),

              SizedBox(height: screenHeight * 0.015),

              AuthButton(
                buttonText: "Redeem",
                onPressed: () {
                  Get.toNamed(RouteName.profileScreen);
                },
                isLoading: false.obs,
              ),

              SizedBox(height: screenHeight * 0.025),

              Center(
                child: SizedBox(
                  width: screenWidth * 0.75, // Responsive width
                  height: screenHeight * 0.1, // Responsive height
                  child: RewardsTabBar(),
                ),
              ),
              // SizedBox(height: screenHeight * 0.02),

              // Rewards List (Responsive)
              RewardCard(
                title: "\$10 Cashback",
                status: "Claimed",
                date: "12 Jan 2025",
                statusIcon: AppImages.done,
                statusColor: Colors.green,
              ),

              SizedBox(height: screenHeight * 0.015),

              RewardCard(
                title: "Free Gear Rental",
                status: "Pending",
                date: "12 Jan 2025",
                statusIcon: AppImages.timer,
                statusColor: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
