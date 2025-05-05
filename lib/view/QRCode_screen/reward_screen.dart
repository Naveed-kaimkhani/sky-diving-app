import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/components/rewards_tab_bar.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import '../../view_model/user_reward_controller.dart';

class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  final referralController = Get.find<ReferralController>();
  final userController = Get.find<UserController>();
  final userRewardController = Get.find<UserRewardController>(); 

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
        final referralData = referralController.referralData.value;
        final isReferralLoading = referralData == null;

        final isRewardLoading = userRewardController.isLoading.value;
        final rewardList = userRewardController.rewards;
        final error = userRewardController.error.value;

        if (isReferralLoading || isRewardLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        if (error.isNotEmpty) {
          return Center(child: Text(error, style: const TextStyle(color: Colors.red)));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                RewardBalanceCard(
                  height: screenHeight * 0.10,
                  width: screenWidth * 0.52,
                  balance: referralData.earnedPoints,
                  
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
                  onPressed: () => Get.toNamed(RouteName.couponsScreen),
                  isLoading: false.obs,
                ),
                SizedBox(height: screenHeight * 0.025),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.6,
                    child: RewardsTabBar(rewardList: rewardList,),
                  ),
                ),

              ],
            ),
          ),
        );
      }),
    );
  }
}
