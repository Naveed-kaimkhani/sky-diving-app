import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class RewardCard extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final String statusIcon;
  final Color statusColor;

  const RewardCard({
    Key? key,
    required this.title,
    required this.status,
    required this.date,
    required this.statusIcon,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section: Title & Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  // Icon(statusIcon, color: statusColor, size: 16),
                  Image.asset(statusIcon , height: 16,width: 16,),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Right Section: Date
          Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
