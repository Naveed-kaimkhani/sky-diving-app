import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/navigation_button.dart';
import 'package:sky_diving/components/referral_card.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/components/shimmer_home_placeholder.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController userController = Get.find<UserController>();
  final referralController = Get.put(ReferralController());

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

        return CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: referralController.fetchReferralData,
            ),
            SliverPadding(
              padding:
                  EdgeInsets.symmetric(horizontal: isSmallScreen ? 10.0 : 20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.qrCode),
                    child: RewardBalanceCard(
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
                    width: screenWidth * 0.18,
                    height: screenHeight * 0.08,
                    rewardText: "Contact Us for ",
                    balance: "More Information",
                    confettiImage: null,
                    coinImage: null,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  RewardBalanceCard(
                    onTap: () => Get.toNamed(RouteName.rentalScreen),
                    width: screenWidth * 0.18,
                    height: screenHeight * 0.08,
                    coinImage: null,
                    confettiImage: null,
                    rewardText: "Order Your Rental ",
                    balance: "Now",
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  RewardBalanceCard(
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.56,
                    balance: data.earnedPoints,
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
                        count: data.activeReferrals.toString(),
                        text: "Active Referrals",
                        width: screenWidth * 0.27,
                      ),
                      ReferralCard(
                        count: data.earnedPoints,
                        text: "Earned Points",
                        width: screenWidth * 0.27,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
