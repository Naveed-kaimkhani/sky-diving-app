// constants/app_text_styles.dart
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle titleLarge = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle titleMedium = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static const TextStyle priceLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static const TextStyle bodyMedium = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static const TextStyle bodySmall = TextStyle(
    color: Colors.white,
    fontSize: 14,
  );


  static const TextStyle bodySubTitle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );
}


// // constants/app_text_styles.dart
// import 'package:flutter/material.dart';
// import 'package:sky_diving/constants/app_colors.dart';

// class AppTextStyles {
//   static TextStyle titleLarge(BuildContext context) => TextStyle(
//     color: Colors.white,
//     fontWeight: FontWeight.bold,
//     fontSize: _getAdaptiveFontSize(context, 20),
//   );

//   static TextStyle titleMedium(BuildContext context) => TextStyle(
//     color: Colors.white,
//     fontSize: _getAdaptiveFontSize(context, 20),
//   );

//   static TextStyle priceLarge(BuildContext context) => TextStyle(
//     color: AppColors.primaryColor,
//     fontWeight: FontWeight.bold,
//     fontSize: _getAdaptiveFontSize(context, 22),
//   );

//   static TextStyle bodyMedium(BuildContext context) => TextStyle(
//     color: Colors.white,
//     fontSize: _getAdaptiveFontSize(context, 16),
//   );

//   static TextStyle bodySmall(BuildContext context) => TextStyle(
//     color: Colors.white,
//     fontSize: _getAdaptiveFontSize(context, 14),
//   );

//   static TextStyle bodySmallSecondary(BuildContext context) => TextStyle(
//     color: Colors.white70,
//     fontSize: _getAdaptiveFontSize(context, 14),
//   );

//   // Helper method to calculate adaptive font size
//   static double _getAdaptiveFontSize(BuildContext context, double baseSize) {
//     final double scaleFactor = _getScaleFactor(context);
//     return baseSize * scaleFactor;
//   }

//   // Calculates scale factor based on screen width
//   static double _getScaleFactor(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
    
//     // Base width is 360 (typical small phone)
//     if (screenWidth < 360) return 0.9;
//     if (screenWidth < 400) return 1.0;
//     if (screenWidth < 600) return 1.1;
//     if (screenWidth < 800) return 1.2;
//     return 1.3;
//   }
// }