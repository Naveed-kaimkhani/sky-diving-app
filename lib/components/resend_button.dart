import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/view_model/count_down_controller.dart';

class ResendButton extends StatelessWidget {
  final CountdownController controller = Get.put(CountdownController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: controller.timeLeft.value == 0
            ? () {
                controller.resetTimer(); // Restart timer when clicked
              }
            : null, // Disable button if countdown is active
        child: RichText(
          text: TextSpan(
            text: "Resend in ",
            style: TextStyle(color: Colors.white, fontSize: 16),
            children: [
              TextSpan(
                text:
                    "00:${controller.timeLeft.value.toString().padLeft(2, '0')}",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    });
  }
}
