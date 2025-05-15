import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';

class AppBarWithBackicon extends StatelessWidget
    implements PreferredSizeWidget {
  final String username;

  AppBarWithBackicon({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black, // Dark background color
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.grey[400], // Light grey text
                  fontSize: 12,
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 10,
          ),
          Stack(
            children: [
              // IconButton(
              //   icon: const Icon(Icons.notifications_none, color: Colors.white),
              //   onPressed: () {},
              // ),
              GestureDetector(
                onTap: () => Get.toNamed(RouteName.notificationsScreen),
                child: SvgPicture.asset(
                  AppSvgIcons.noti,
                  color: Colors.white,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
