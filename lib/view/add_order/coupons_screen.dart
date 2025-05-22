import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sky_diving/components/coupon_card.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';
import 'package:intl/intl.dart';

class CouponsScreen extends StatelessWidget {
  CouponsScreen({Key? key}) : super(key: key);

  final UserRewardController _controller = Get.find<UserRewardController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Available Coupons",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose a coupon to apply or copy to your clipboard.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (_controller.isLoading.value) {
                return _buildShimmerEffect();
              } else if (_controller.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    _controller.error.value,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (_controller.rewards.isEmpty) {
                return Center(
                  child: Text(
                    'No coupons available',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _controller.rewards.length,
                    itemBuilder: (context, index) {
                      final reward = _controller.rewards[index];
                      return CouponCard(
                        status: reward.status,
                        expiryDate:
                            reward.expiryDate, // assumed already formatted
                        code: reward.couponCode,
                        description: '${reward.points} points ',
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 150,
                      height: 24,
                      color: Colors.grey[800],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.grey[800],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.grey[800],
                        ),
                        SizedBox(width: 4),
                        Container(
                          width: 120,
                          height: 14,
                          color: Colors.grey[800],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 100,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
