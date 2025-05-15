
import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final double tileMargin;
  final double tilePadding;
  final double titleFontSize;
  final double subtitleFontSize;
  final double dateFontSize;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.tileMargin,
    required this.tilePadding,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.dateFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(tilePadding),
      margin: EdgeInsets.only(bottom: tileMargin),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius:
            BorderRadius.circular(tilePadding * 1.5), // Responsive radius
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: tilePadding * 0.3), // Responsive spacing
                Text(
                  subtitle,
                  style: TextStyle(
                      color: Colors.white70, fontSize: subtitleFontSize),
                ),
              ],
            ),
          ),
          SizedBox(width: tilePadding * 0.8), // Responsive spacing
          Text(
            date,
            style: TextStyle(
                color: AppColors.primaryColor, fontSize: dateFontSize),
          ),
        ],
      ),
    );
  }
}
