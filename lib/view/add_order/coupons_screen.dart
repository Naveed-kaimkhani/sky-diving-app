import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sky_diving/components/coupon_card.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/constants/app_colors.dart';

class CouponsScreen extends StatelessWidget {
  // Sample list of coupons
  final List<Map<String, String>> coupons = [
    {'code': 'SKY50', 'description': 'Get 50% off on skydiving gear!'},
    {
      'code': 'FREE100',
      'description': 'Free skydiving session for first 100 users!'
    },
    {'code': 'RIDE10', 'description': 'Save \$10 on your next jump!'},
    {'code': 'GIFT20', 'description': 'Gift card worth \$20!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
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
                color: Colors.grey[300], // Light text on dark background
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  return CouponCard(
                    code: coupon['code']!,
                    description: coupon['description']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
