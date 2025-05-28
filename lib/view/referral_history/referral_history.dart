import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/components/referral_item.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/models/referral_model.dart';
import 'package:sky_diving/view/referral_history/user_points_detail_screen.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

// class ReferralHistory extends StatelessWidget {
//   ReferralHistory({super.key});

//   final UserController userController = Get.find<UserController>();
//   final userRewardController = Get.find<UserRewardController>();

//   final ReferralController referralController = Get.find<ReferralController>();

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: CustomAppBar(
//         username: userController.user.value?.name ?? "",
//         profileImage: AppSvgIcons.profile,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenHeight * 0.02),
//             LabelText(
//               text: "Referral Points History",
//               fontSize: screenWidth * 0.045,
//             ),
//             SizedBox(height: screenHeight * 0.015),
//             Expanded(
//               // Wrap the tab bar in Expanded
//               child: CustomTabBar(userRewardController: userRewardController),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomTabBar extends StatelessWidget {
//   final UserRewardController userRewardController;

//   final ReferralController referralController = Get.find<ReferralController>();
//   CustomTabBar({super.key, required this.userRewardController});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: TabBar(
//               dividerColor: Colors.transparent,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 color: AppColors.primaryColor,
//               ),
//               labelStyle: TextStyle(
//                 fontSize: screenWidth * 0.031,
//               ),
//               labelColor: Colors.black,
//               unselectedLabelColor: Colors.white,
//               tabs: const [
//                 Tab(text: '   All   '),
//                 Tab(text: ' Pending  '),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             // Wrap TabBarView in Expanded
//             child: TabBarView(
//               children: [
//                 // All tab
//                 _buildRewardList(
//                     referralController.referralData.value!.referrals),
//                 // Pending tab - filter rewards where status is "Pending"
//                 _buildRewardListWithFilter(
//                     userRewardController.rewards, "Pending"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRewardList(List<Referral> rewards) {
//     final ReferralController referralController =
//         Get.find<ReferralController>();
//     return Obx(() {
//       final isLoading = userRewardController.isLoading.value;
//       final error = userRewardController.error.value;

//       if (isLoading) {
//         return const Center(
//           child: CircularProgressIndicator(color: Colors.white),
//         );
//       }

//       if (error.isNotEmpty) {
//         return Center(
//           child: Text(error, style: const TextStyle(color: Colors.red)),
//         );
//       }

//       if (rewards.isEmpty) {
//         return const Center(
//           child: Text("No referral rewards yet",
//               style: TextStyle(color: Colors.white)),
//         );
//       }

//       return ListView.builder(
//         itemCount: rewards.length,
//         itemBuilder: (context, index) {
//           final reward = rewards[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => UserPointsDetailScreen(
//                         userId: reward.id,
//                         userName: reward.referredName,
//                         // url: reward.avatarUrl,
//                         url: reward.avatarUrl,
//                         totalPoints: int.parse(reward.totalPoints),
//                       )));
//             },
//             child: TransactionCard(
//               amount: reward.totalPoints,
//               name: reward.referredName,
//               date: reward.referralDate.toString(),
//               statusImagePath: AppImages.done,
//               calendarImagePath: AppImages.timer,
//               amountColor: AppColors.primaryColor,
//               iconColor: Colors.green,
//             ),
//           );
//         },
//       );
//     });
//   }

//   Widget _buildRewardListWithFilter(
//       List<UserReward> rewards, String statusFilter) {
//     final ReferralController referralController =
//         Get.find<ReferralController>();
//     return Obx(() {
//       final isLoading = userRewardController.isLoading.value;
//       final error = userRewardController.error.value;
//       final filteredRewards =
//           rewards.where((reward) => reward.status == statusFilter).toList();

//       if (isLoading) {
//         return const Center(
//           child: CircularProgressIndicator(color: Colors.white),
//         );
//       }
//       if (error.isNotEmpty) {
//         return Center(
//           child: Text(error, style: const TextStyle(color: Colors.red)),
//         );
//       }

//       if (filteredRewards.isEmpty) {
//         return Center(
//           child: Text("No $statusFilter referral rewards yet",
//               style: const TextStyle(color: Colors.white)),
//         );
//       }

//       return ListView.builder(
//         itemCount: filteredRewards.length,
//         itemBuilder: (context, index) {
//           final reward = filteredRewards[index];
//           final matchingReferral =
//               referralController.referralData.value?.referrals.firstWhereOrNull(
//             (referral) {
//               return referral.id == reward.userReferalId;
//             },
//           );
//           final name = matchingReferral?.referredName ?? "Unknown";

//           return GestureDetector(
//             // onTap: () => Get.to(() => UserPointsDetailScreen(
//             //       userName: name,
//             //       userId: "34", // Pass the user ID
//             //       points: reward.points,
//             //     )),
//             onTap: () => log("fdfldskjflsjflksj"),
//             child: TransactionCard(
//               amount: "${reward.points}",
//               name: name,
//               date: DateFormat('MM dd, yyyy').format(reward.createdAt),
//               // date: reward.createdAt.toString(),

//               statusImagePath:
//                   statusFilter == "active" ? AppImages.done : AppImages.timer,
//               calendarImagePath: AppImages.timer,
//               amountColor: AppColors.primaryColor,
//               iconColor:
//                   statusFilter == "active" ? Colors.green : Colors.yellow,
//             ),
//           );
//         },
//       );
//     });
//   }
// }

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
              text: "Referral Points History",
              fontSize: screenWidth * 0.045,
            ),
            SizedBox(height: screenHeight * 0.015),
            Expanded(
              child: _buildRewardList(
                referralController.referralData.value!.referrals,
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
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPointsDetailScreen(
                  userId: reward.id,
                  userName: reward.referredName,
                  url: reward.avatarUrl,
                  totalPoints: int.parse(reward.totalPoints),
                ),
              ));
            },
            child: TransactionCard(
              amount: reward.totalPoints,
              name: reward.referredName,
              date: reward.referralDate.toString(),
              statusImagePath: AppImages.done,
              calendarImagePath: AppImages.timer,
              amountColor: AppColors.primaryColor,
              iconColor: Colors.green,
            ),
          );
        },
      );
    });
  }
}
