import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
          // ClipOval(
          //     child: Icon(
          //   Icons.person,
          //   size: 34,
          //   color: Colors.white,
          // )),
          ClipOval(
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors
                    .grey[300], // Background color when no image is present
                image: userController.user.value!.proiflePic != null &&
                        userController.user.value!.proiflePic!.isNotEmpty
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(
                            userController.user.value!.proiflePic!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: userController.user.value!.proiflePic == null ||
                      userController.user.value!.proiflePic!.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 24, // Icon size adjusted to fit inside 34 size
                      color: Colors.white,
                    )
                  : null,
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
