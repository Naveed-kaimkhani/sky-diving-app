import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String profileImage;
  bool? isShowBackButton;
  CustomAppBar({
    super.key,
    this.isShowBackButton,
    required this.username,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black, // Dark background color
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          ClipOval(
              child: Icon(
            Icons.person,
            size: 34,
            color: Colors.white,
          )),
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
