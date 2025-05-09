import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/referral_item.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

class ReferralHistory extends StatelessWidget {
  ReferralHistory({super.key});

  final UserController userController = Get.find<UserController>();
  final userRewardController = Get.find<UserRewardController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: userController.user.value?.name ?? "",
        profileImage: AppSvgIcons.profile,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive horizontal padding
        ),
        child: SingleChildScrollView(child: Obx(() {
          final rewardList = userRewardController.rewards;
          final isLoading = userRewardController.isLoading.value;
          final error = userRewardController.error.value;

          if (isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          if (error.isNotEmpty) {
            return Center(
                child: Text(error, style: TextStyle(color: Colors.red)));
          }

          if (rewardList.isEmpty) {
            return Center(
                child: Text("No referral rewards yet",
                    style: TextStyle(color: Colors.white)));
          }

          return Column(
            children: rewardList.map((reward) {
              return TransactionCard(
                amount:
                    "\$${reward.discount}", // Adjust based on your reward model
                name: "Unknown",
                date: reward.createdAt.toString(),
                statusImagePath: AppImages.done,
                calendarImagePath: AppImages.timer,
                amountColor: AppColors.primaryColor,
                iconColor: Colors.green,
              );
            }).toList(),
          );
        })

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     SizedBox(height: screenHeight * 0.02),
            //     LabelText(
            //       text: "Referral History",
            //       fontSize: screenWidth * 0.045, // Responsive font size
            //     ),
            //     SizedBox(height: screenHeight * 0.015),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         SizedBox(
            //           width: screenWidth * 0.9, // Responsive width
            //           height: screenHeight * 0.1, // Responsive height
            //           child: CustomTabBar(),
            //         ),
            //       ],
            //     ),
            //     GestureDetector(
            //       onTap: () => Get.toNamed(RouteName.rewardScreen),
            //       child: TransactionCard(
            //         amount: "\$10",
            //         name: "Jane Doe",
            //         date: "12 Jan 2025",
            //         statusImagePath: AppImages.done,
            //         calendarImagePath: AppImages.timer,
            //         amountColor: AppColors.primaryColor,
            //         iconColor: Colors.green,
            //       ),
            //     ),
            //     SizedBox(height: screenHeight * 0.015),
            //     TransactionCard(
            //       amount: "\$20",
            //       name: "John Smith",
            //       date: "12 Jan 2025",
            //       statusImagePath: AppImages.timer,
            //       calendarImagePath: AppImages.timer,
            //       amountColor: Colors.yellow,
            //       iconColor: Colors.yellow,
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
