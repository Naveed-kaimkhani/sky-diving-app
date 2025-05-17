import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/profile_widget.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view_model/user_controller.dart';

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

  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black, // Dark background color
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            child: ProfileWidget(userController: userController),
            onTap: () => Get.toNamed(RouteName.updateProfile),
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
