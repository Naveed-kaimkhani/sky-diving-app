import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/view/notification_screen/notification_tile.dart';
import 'package:sky_diving/view_model/notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final padding = screenWidth * 0.04;
    final tileMargin = screenHeight * 0.01;
    final tilePadding = screenWidth * 0.03;
    final titleFontSize = screenWidth * 0.042;
    final subtitleFontSize = screenWidth * 0.034;
    final dateFontSize = screenWidth * 0.033;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Notifications",
      ),
      body: Obx(() {
        if (notificationController.isLoading.value) {
          return Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ));
        }

        if (notificationController.notifications.isEmpty) {
          return Center(
              child: Text("No notifications",
                  style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
          padding: EdgeInsets.all(padding),
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            final item = notificationController.notifications[index];
            return NotificationTile(
              title: item.title,
              subtitle: item.subtitle,
              date: item.date,
              tileMargin: tileMargin,
              tilePadding: tilePadding,
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
              dateFontSize: dateFontSize,
            );
          },
        );
      }),
    );
  }
}
