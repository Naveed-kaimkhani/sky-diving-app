import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/utils/contact_utils.dart';

class ContactInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;
    // final iconSize = size.width * 0.08;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        title: "Contact Information",
        onBackPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            // Header with parachute icon
            Column(
              children: [
                Icon(
                  Icons.paragliding,
                  size: size.width * 0.2,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 10),
                Text(
                  'Skydiving Gear Rental & Sales',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),

            // Contact cards
            _buildContactCard(
              context,
              icon: Icons.email,
              title: "Email",
              value: "skydivingrental@gmail.com",
              color: Colors.blueAccent,
              onTap: () {
                ContactUtils.launchEmail(
                  context: context,
                  subject: 'Skydiving Gear Inquiry',
                  body: 'Hello Skydiving Gear Rental Team,\n\n',
                );
              },
            ),
            SizedBox(height: size.height * 0.03),

            _buildContactCard(
              context,
              icon: Icons.phone,
              title: "Phone",
              value: "720-352-2151",
              color: Colors.green,
              onTap: () => ContactUtils.launchPhone(context: context),
            ),
            SizedBox(height: size.height * 0.03),

            _buildContactCard(
              context,
              icon: Icons.language,
              title: "Website",
              value: "sgras.com",
              color: Colors.purpleAccent,
              onTap: () => ContactUtils.launchWebsite(context: context),
            ),

            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(size.width * 0.03),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: size.width * 0.07),
            ),
            SizedBox(width: size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.043,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
