import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class ReferralCard extends StatelessWidget {
  final String count;
  final String text;
  final double? width;

  final double? height;
  const ReferralCard({
    super.key,
    required this.count,
    this.text = "Total Referrals",
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        width ?? screenWidth * 0.28; // ~28% of screen width by default
    final cardHeight =
        cardWidth * 0.94; // Maintain original aspect ratio (92/98)

    return Container(
      width: cardWidth,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: cardWidth * 0.17, // 24/98 ratio
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: cardHeight * 0.054), // 5/92 ratio
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: cardWidth * 0.08, // 12/98 ratio
            ),
          ),
        ],
      ),
    );
  }
}
