

import 'package:flutter/material.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    final padding = screenWidth * 0.04; // 4% of screen width
    final tileMargin = screenHeight * 0.01; // 1% of screen height
    final tilePadding = screenWidth * 0.03; // 3% of screen width
    final titleFontSize = screenWidth * 0.042; // 4.5% of screen width
    final subtitleFontSize = screenWidth * 0.034; // 3.7% of screen width
    final dateFontSize = screenWidth * 0.033; // 3.3% of screen width

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
          username: "Jaydon Bator", profileImage: AppSvgIcons.profile),
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: [
          NotificationTile(
              title: "New Reward Added",
              subtitle: "New Reward Added - \$10 Cashback",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
          NotificationTile(
              title: "Referral Signed Up",
              subtitle: "Referral Signed Up - Jane Doe",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
          NotificationTile(
              title: "Reward Redeemed",
              subtitle: "Reward Redeemed - Free Gear Rental",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
          NotificationTile(
              title: "Referral Bonus Earned",
              subtitle: "Referral Bonus Earned - \$20 for John Smith's Signup",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
          NotificationTile(
              title: "App Update Available",
              subtitle:
                  "New App Update Available - Tap to Download the Latest Version",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
          NotificationTile(
              title: "Reward Expiry Reminder",
              subtitle: "Hurry! Your \$10 Cashback Reward Expires in 3 Days",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
          NotificationTile(
              title: "Referral Reward Approved",
              subtitle: "Referral Reward Approved - \$15 for Jane Doe's Signup",
              date: "12 Jan 2025",
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize),
        ],
      ),
    );
  }
}

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
