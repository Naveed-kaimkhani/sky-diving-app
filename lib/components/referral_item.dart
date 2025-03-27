// import 'package:flutter/material.dart';
// import 'package:sky_diving/constants/app_colors.dart';

// class TransactionCard extends StatelessWidget {
//   final String amount;
//   final String name;
//   final String date;
//   final IconData statusIcon;
//   final Color amountColor;
//   final Color iconColor;

//   const TransactionCard({
//     Key? key,
//     required this.amount,
//     required this.name,
//     required this.date,
//     required this.statusIcon,
//     required this.amountColor,
//     required this.iconColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           // Amount Badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: amountColor.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               amount,
//               style: TextStyle(
//                 color: amountColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),

//           // Name and Date
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_today, color: Colors.green, size: 16),
//                     const SizedBox(width: 4),
//                     Text(
//                       date,
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Status Icon
//           Icon(
//             statusIcon,
//             color: iconColor,
//             size: 24,
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String name;
  final String date;
  final String statusImagePath;  // Changed from IconData to String
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
          // Amount Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: amountColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              amount,
              style: TextStyle(
                color: amountColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // Image.asset(
                    //   calendarImagePath,
                    //   width: 16,
                    //   height: 16,
                    //   color: Colors.green,
                    // ),
                    Icon(Icons.calendar_month_rounded, size: 16, color: iconColor,),
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

          // Status Icon
          Image.asset(
            statusImagePath,
            width: 24,
            height: 24,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}