
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart'; // ✅ Add this
import 'package:sky_diving/components/navigation_button.dart';
import 'package:sky_diving/components/referral_card.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/components/scan_component.dart';
import 'package:sky_diving/components/shimmer_home_placeholder.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/utils/utils.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_points_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController userController = Get.find<UserController>();
  final ReferralController referralController = Get.find<ReferralController>();
  final UserRewardController rewardController =
      Get.find<UserRewardController>();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final UserPointsController userRewardController =
      Get.put(UserPointsController());

  Future<void> _onRefresh() async {
    bool isConnected = await Utils.checkInternetConnection();
    if (!isConnected) return;

    await referralController.fetchReferralData();

    await rewardController.fetchUserRewards(userController.token.value);
    final UserPointsController userRewardController =
        Get.put(UserPointsController());
    userRewardController.fetchRewards();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: userController.user.value!.name,
        profileImage: AppSvgIcons.profile,
      ),
      body: Obx(() {
        final data = referralController.referralData.value;
        final isLoading = data == null;

        if (isLoading) {
          return ShimmerHomePlaceholder(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          );
        }
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          enablePullDown: true,
          header: CustomHeader(
            builder: (BuildContext context, RefreshStatus? mode) {
              if (mode == RefreshStatus.refreshing) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 14,
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: isSmallScreen ? 10.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteName.qrCode),
                  child: ScanComponent(
                    width: screenWidth * 0.18,
                    height: screenHeight * 0.08,
                    rewardText: "Scan to Refer a Friend",
                    balance: "${data.activeReferrals} Completed",
                    coinImage: null,
                    confettiImage: AppSvgIcons.scan,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                RewardBalanceCard(
                  onTap: () => Get.toNamed(RouteName.contactInfoScreen),
                  width: screenWidth * 0.18,
                  height: screenHeight * 0.08,
                  rewardText: "Contact Us For ",
                  balance: "More Information",
                  confettiImage: AppImages.contractus,
                  coinImage: null,
                ),
                SizedBox(height: screenHeight * 0.02),
                RewardBalanceCard(
                  onTap: () => Get.toNamed(RouteName.mainPage),
                  width: screenWidth * 0.18,
                  height: screenHeight * 0.08,
                  coinImage: null,
                  confettiImage: AppImages.ordernow,
                  rewardText: "Order Your Rental ",
                  balance: "Now",
                ),
                SizedBox(height: screenHeight * 0.02),
                RewardBalanceCard(
                  height: screenHeight * 0.08,
                  width: screenWidth * 0.56,
                  balance: data.earnedPoints,
                  rewardText: "Total Points",
                  coinImage: AppSvgIcons.coin,
                  confettiImage: AppSvgIcons.confettiImage,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReferralCard(
                      count: data.totalReferrals.toString(),
                      text: "Total Referrals",
                      width: screenWidth * 0.27,
                    ),
                    ReferralCard(
                      count: data.usedPoints,
                      // count: "343427",
                      text: "Used Points",
                      width: screenWidth * 0.27,
                    ),
                    ReferralCard(
                      count: data.remainingPoints,
                      text: "Remaining Points",
                      width: screenWidth * 0.27,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigationButton(
                      text: "FAQs",
                      onPressed: () => Get.toNamed(RouteName.fAQScreen),
                      width: screenWidth * 0.4,
                    ),
                    NavigationButton(
                      text: "Help & Support",
                      onPressed: () =>
                          Get.toNamed(RouteName.emailSupportScreen),
                      width: screenWidth * 0.4,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.12),
              ],
            ),
          ),
        );
      }),
    );
  }
}
