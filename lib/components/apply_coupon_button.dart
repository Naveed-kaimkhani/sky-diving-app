// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sky_diving/constants/app_colors.dart';
// import 'package:sky_diving/view_model/user_reward_controller.dart';

// class ApplyCouponButton extends StatelessWidget {
//   final rewardController = Get.find<UserRewardController>();

//   ApplyCouponButton({
//     super.key,
//     required this.couponController,
//   });

//   final TextEditingController couponController;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         // TODO: Add logic to validate and apply coupon
//         print("Coupon applied: ${couponController.text}");

//         () {
//           final enteredCode = couponController.text.trim();
//           final rewardMatch = rewardController.rewards.firstWhereOrNull(
//             (reward) =>
//                 reward.couponCode.toLowerCase() == enteredCode.toLowerCase(),
//           );

//           if (rewardMatch != null) {
//             // ✅ Valid coupon found
//             print("Coupon applied: ${rewardMatch.couponCode}");
//             print("Discount: ${rewardMatch.discount}");
//             // TODO: Apply discount logic here (e.g., subtract from subtotal)
//           } else {
//             // ❌ No valid coupon
//             print("Invalid or expired coupon");
//             // Optionally show a Snackbar or error message
//           }
//         };
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryColor,
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text("Apply", style: TextStyle(color: Colors.black)),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sky_diving/constants/app_colors.dart';
// import 'package:sky_diving/models/user_reward_model.dart';
// import 'package:sky_diving/view_model/user_controller.dart';
// import 'package:sky_diving/view_model/user_reward_controller.dart';

// class ApplyCouponButton extends StatelessWidget {
//   ApplyCouponButton({
//     super.key,
//     required this.couponController,
//   });

//   final TextEditingController couponController;

//   @override
//   Widget build(BuildContext context) {
//     // ✅ Register controller if not already
//     if (!Get.isRegistered<UserRewardController>()) {
//       Get.put(UserRewardController());
//     }

//     final rewardController = Get.find<UserRewardController>();

//     final UserController userController = Get.find<UserController>();
//     return ElevatedButton(
//       onPressed: () async {
//         final enteredCode = couponController.text.trim();

//         // ✅ If reward list is empty, fetch user rewards (token should be passed here)
//         if (rewardController.rewards.isEmpty) {
//           // Replace with actual token
//           String userToken = userController.token.value;
//           await rewardController.fetchUserRewards(userToken);
//         }

//         final rewardMatch = rewardController.rewards.firstWhereOrNull(
//           (reward) =>
//               reward.couponCode.toLowerCase() == enteredCode.toLowerCase(),
//         );

//         if (rewardMatch != null) {
//           Get.snackbar(
//             "Coupon Applied ✅",
//             "${rewardMatch.couponCode} - Discount: ${rewardMatch.discount}",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green.shade100,
//             colorText: Colors.black,
//           );
//           // TODO: Apply this discount to subtotal or relevant cost
//         } else {
//           Get.snackbar(
//             "Invalid Coupon ❌",
//             "The coupon code you entered is not valid or has expired.",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red.shade100,
//             colorText: Colors.black,
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryColor,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: const Text("Apply", style: TextStyle(color: Colors.black)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/models/user_reward_model.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

class ApplyCouponButton extends StatelessWidget {
  ApplyCouponButton({
    super.key,
    required this.couponController,
  });

  final TextEditingController couponController;

  @override
  Widget build(BuildContext context) {
    // ✅ Register controller if not already
    if (!Get.isRegistered<UserRewardController>()) {
      Get.put(UserRewardController());
    }

    final rewardController = Get.find<UserRewardController>();
    final UserController userController = Get.find<UserController>();

    return Obx(() {
      return ElevatedButton(
        onPressed: rewardController.isLoading.value
            ? null // Disable the button when loading
            : () async {
                rewardController.isLoading.value = true;
                final enteredCode = couponController.text.trim();

                // ✅ If reward list is empty, fetch user rewards (token should be passed here)
                if (rewardController.rewards.isEmpty) {
                  // Replace with actual token
                  String userToken = userController.token.value;
                  await rewardController.fetchUserRewards(userToken);
                }

                final rewardMatch = rewardController.rewards.firstWhereOrNull(
                  (reward) =>
                      reward.couponCode.toLowerCase() ==
                      enteredCode.toLowerCase(),
                );

                if (rewardMatch != null) {
                  rewardController.isLoading.value = false;
                  Get.snackbar(
                    "Coupon Applied ✅",
                    "${rewardMatch.couponCode} - Discount: ${rewardMatch.discount}",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green.shade100,
                    colorText: Colors.black,
                  );
                  // TODO: Apply this discount to subtotal or relevant cost
                } else {
                  rewardController.isLoading.value = false;
                  Get.snackbar(
                    "Invalid Coupon ❌",
                    "The coupon code you entered is not valid or has expired.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.shade100,
                    colorText: Colors.black,
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: rewardController.isLoading.value
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              )
            : const Text("Apply", style: TextStyle(color: Colors.black)),
      );
    });
  }
}
