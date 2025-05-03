import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class ApplyCouponButton extends StatelessWidget {
  const ApplyCouponButton({
    super.key,
    required this.couponController,
  });

  final TextEditingController couponController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Add logic to validate and apply coupon
        print("Coupon applied: ${couponController.text}");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Apply", style: TextStyle(color: Colors.black)),
    );
  }
}
