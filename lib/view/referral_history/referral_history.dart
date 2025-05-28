import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/components/referral_item.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/models/referral_model.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

class ReferralHistory extends StatelessWidget {
  ReferralHistory({super.key});

  final UserController userController = Get.find<UserController>();
  final ReferralController referralController = Get.find<ReferralController>();
  final UserRewardController userRewardController =
      Get.find<UserRewardController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: userController.user.value?.name ?? "",
        // profileImage: AppSvgIcons.profile,
        profileImage: userController.user.value!.proiflePic ?? "",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            LabelText(
              text: "Referral History",
              fontSize: screenWidth * 0.045,
            ),
            SizedBox(height: screenHeight * 0.015),
            Expanded(
              child: _buildRewardList(
                referralController.referralData.value!.referrals.reversed
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardList(List<Referral> rewards) {
    return Obx(() {
      final isLoading = userRewardController.isLoading.value;
      final error = userRewardController.error.value;

      if (isLoading) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }

      if (error.isNotEmpty) {
        return Center(
          child: Text(error, style: const TextStyle(color: Colors.red)),
        );
      }

      if (rewards.isEmpty) {
        return const Center(
          child: Text("No referral rewards yet",
              style: TextStyle(color: Colors.white)),
        );
      }

      return ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return TransactionCard(
            amount: reward.totalPoints,
            name: reward.referredName,
            date: reward.referralDate.toString(),
            statusImagePath: AppImages.done,
            calendarImagePath: AppImages.timer,
            amountColor: AppColors.primaryColor,
            iconColor: Colors.green,
          );
        },
      );
    });
  }
}
