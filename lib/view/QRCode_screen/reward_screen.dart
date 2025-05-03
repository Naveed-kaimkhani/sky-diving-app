import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/components/redeem_success_popup.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/components/reward_card.dart';
import 'package:sky_diving/components/rewards_tab_bar.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';


class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  final referralController = Get.find<ReferralController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: userController.user.value?.name ?? "",
        profileImage: AppSvgIcons.profile,
      ),
      body: Obx(() {
        final data = referralController.referralData.value;
        final isLoading = data == null;

        if (isLoading) {
          // You can replace this with a shimmer or loading widget if you have one
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                RewardBalanceCard(
                  height: screenHeight * 0.10,
                  width: screenWidth * 0.52,
                  balance: "\$${data.earnedPoints}",
                  coinImage: AppSvgIcons.coin,
                  confettiImage: AppSvgIcons.confettiImage,
                ),

                SizedBox(height: screenHeight * 0.03),

                LabelText(
                  text: "Rewards",
                  fontSize: screenWidth * 0.045,
                  weight: FontWeight.bold,
                ),

                SizedBox(height: screenHeight * 0.015),

                AuthButton(
                  buttonText: "Redeem",
                  onPressed: () =>// To show the popup
showDialog(
  context: context,
  builder: (BuildContext context) {
    return RedeemSuccessPopup();
  },
),
                  isLoading: false.obs,
                ),

                SizedBox(height: screenHeight * 0.025),

                Center(
                  child: SizedBox(
                    width: screenWidth * 0.75,
                    height: screenHeight * 0.1,
                    child: RewardsTabBar(),
                  ),
                ),

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
        );
      }),
    );
  }
}

