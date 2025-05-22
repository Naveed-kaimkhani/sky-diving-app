import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/redeem_sucess_popup.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class RedeemDialog extends StatelessWidget {
  final TextEditingController pointsController;
  final ReferralController referralController;

  final UserController userController = Get.find<UserController>();
  RedeemDialog({
    super.key,
    required this.pointsController,
    required this.referralController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(screenWidth * 0.05),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A2A2A), Color(0xFF121212)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with confetti decoration
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/svg/confetti.png',
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.1,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Redeem Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            // Points input field with coin icon
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryColor, width: 1),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: TextField(
                      controller: pointsController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter points to redeem',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            Text(
              'Available: ${referralController.referralData.value?.remainingPoints ?? 0} points',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: screenWidth * 0.04,
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.04),

                // Redeem button
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (pointsController.text.isNotEmpty) {
                        int points = int.tryParse(pointsController.text) ?? 0;
                        if (points > 0 &&
                            points <=
                                int.parse(referralController
                                        .referralData.value?.earnedPoints ??
                                    '0')) {
                          await referralController.redeemUserPoints(
                              points,
                              userController
                                  .token.value); // ✅ Redeem via controller
                          Navigator.pop(context);
                          _showRedeemDialog(context);
                        } else {
                          Get.snackbar(
                            'Invalid Points',
                            'Please enter a valid number of points',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF0DEE23),
                            Color(0xFF0BB620),
                          ],
                          stops: [0.0, 0.8],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF0DEE23).withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        // child: Text(
                        //   'Redeem Now',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: screenWidth * 0.04,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        child: Obx(() {
                          return referralController.isRedeeming.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.black,
                                  ),
                                )
                              : Text(
                                  'Redeem Now',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRedeemDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => RedeemSuccessPopup());
  }
}
