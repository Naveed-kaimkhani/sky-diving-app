import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: userController.user.value!.proiflePic ?? '',
        width: 34,
        height: 34,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 34,
          height: 34,
          color: Colors.grey[300],
          child: Icon(
            Icons.person,
            size: 20,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: 34,
          height: 34,
          color: Colors.grey[300],
          child: Icon(
            Icons.person,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
