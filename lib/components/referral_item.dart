import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String name;
  final String date;
  final String statusImagePath; // Changed from IconData to String
  final String calendarImagePath; // New parameter for calendar icon
  final Color amountColor;
  final Color iconColor;

  const TransactionCard({
    Key? key,
    required this.amount,
    required this.name,
    required this.date,
    required this.statusImagePath,
    required this.calendarImagePath,
    required this.amountColor,
    required this.iconColor,
  }) : super(key: key);
  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),

          // Name and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 16,
                      color: iconColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
