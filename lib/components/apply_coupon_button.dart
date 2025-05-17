import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/view_model/rental_view_model.dart';
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

    return Obx(() {
      return ElevatedButton(
        onPressed: rewardController.isLoading.value
            ? null // Disable the button when loading
            : () async {
if (couponController.text.isEmpty) {
                  Get.snackbar(
                    "Empty Coupon Code ❌",
                    "Please enter a coupon code.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.shade100,
                    colorText: Colors.black,
                  );
                  return;
}
                rewardController.isLoading.value = true;
                final enteredCode = couponController.text.trim();
             final rewardMatch = rewardController.rewards.firstWhereOrNull(
                  (reward) =>
                      reward.couponCode.toLowerCase() ==
                      enteredCode.toLowerCase(),
                );
         if (rewardMatch != null) 
        {
  rewardController.isLoading.value = false;
  final rentalVM = Get.find<RentalViewModel>();
String discountStr = rewardMatch.discount.toString();
int discount = double.parse(discountStr).toInt();
  if (rentalVM.subtotal.value < 0) rentalVM.subtotal.value = 0;
  rentalVM.subtotal.value  = rentalVM.subtotal.value-discount;
  Get.snackbar(
    "Coupon Applied ✅",
    "${rewardMatch.couponCode} - Discount: \$${discount}",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.shade100,
    colorText: Colors.black,
  );
}

                 else {
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
