import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String profileImage;

  const CustomAppBar({
    super.key,
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
            child:  Image.asset(
              height: 40,
              width: 40,
              profileImage,
            )
            //  CachedNetworkImage(
            //   imageUrl: profileImage,
            //   width: 40,
            //   height: 40,
            //   fit: BoxFit.cover,
            //   placeholder: (context, url) =>
            //       CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            //   errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
            // ),
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
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white ,size: 22,),
            onPressed: () {},
          ),
          SizedBox(width: 10,),
          Stack(
            children: [
              // IconButton(
              //   icon: const Icon(Icons.notifications_none, color: Colors.white),
              //   onPressed: () {},
              // ),
              SvgPicture.asset(
                AppSvgIcons.noti,
                color: Colors.white,
                height: 22,
                width: 22,
              ),
              // Positioned(
              //   top: 10,
              //   right: 10,
              //   child: Container(
              //     width: 8,
              //     height: 8,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       shape: BoxShape.circle,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
