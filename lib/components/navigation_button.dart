import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const NavigationButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = screenWidth * 0.4; // Default to 40% of screen width
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? baseWidth,
        padding: EdgeInsets.symmetric(
          vertical: 12, // Maintain fixed vertical padding
          horizontal: baseWidth * 0.1, // ~16/160 ratio (original was 16px on ~160px button)
        ),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14, // Maintain fixed font size for readability
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(width: baseWidth * 0.0625), // 10/160 ratio
            Icon(
              Icons.arrow_forward,
              color: AppColors.primaryColor,
              size: 18, // Maintain fixed icon size
            ),
          ],
        ),
      ),
    );
  }
}