import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_diving/constants/app_colors.dart';

class RewardBalanceCard extends StatelessWidget {
  final String balance;
  final String rewardText;
  final String? coinImage;
  final String? confettiImage;
  final double width;
    final double height;
  const RewardBalanceCard({
    super.key,
    required this.width,
    required this.balance,
    required this.height,
    this.rewardText = "Reward Balance",
    required this.coinImage,
    required this.confettiImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
     color: const Color.fromARGB(255, 26, 25, 25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Reward text and balance
        
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rewardText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                balance,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // const Spacer(),
          // Confetti and coin image
          Stack(
            children: [
             confettiImage!=null? Image.asset(
                fit: BoxFit.cover,  
                confettiImage??"",
                width: width,
                height: height,
              ):SizedBox(),
          coinImage!=null?    Positioned(
                right: 5,
                bottom: 5,
                child: Image.asset(
                  coinImage??"",
                  width: 50,
                  height: 50,
                ),
              ):SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
