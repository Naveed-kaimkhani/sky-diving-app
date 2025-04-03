import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  
  final bool? showSubTitle;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  const TitleAppBar({
    Key? key,
    required this.title,
    this.showSubTitle = false,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
  (showSubTitle == true) ? Text(
            "support@skydiving.com",
            style: const TextStyle(color: AppColors.primaryColor, fontSize: 10),
          ) :SizedBox()
        ],
      ),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}