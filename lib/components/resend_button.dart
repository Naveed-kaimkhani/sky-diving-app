// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sky_diving/view_model/count_down_controller.dart';

// class ResendButton extends StatelessWidget {
//   final CountdownController controller = Get.put(CountdownController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final bool isTimerDone = controller.timeLeft.value == 0;

//       return AnimatedOpacity(
//         duration: Duration(milliseconds: 500),
//         opacity: isTimerDone ? 1.0 : 0.4, // Fade while timer is active
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.black,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           onPressed: isTimerDone
//               ? () {
//                   controller.resetTimer(); // Restart timer
//                   Get.snackbar("OTP", "OTP resent successfully!",
//                       colorText: Colors.white);
//                 }
//               : null, // Disabled when timer is active
//           child: RichText(
//             text: TextSpan(
//               text: "Resend in ",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//               children: [
//                 TextSpan(
//                   text:
//                       "00:${controller.timeLeft.value.toString().padLeft(2, '0')}",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/view_model/auth_controller.dart';
import 'package:sky_diving/view_model/count_down_controller.dart';

class ResendButton extends StatelessWidget {
  final CountdownController controller = Get.put(CountdownController());

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isTimerDone = controller.timeLeft.value == 0;

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
    onPressed: isTimerDone
    ? () async {
         authController.resendOtp(authController.phoneNumber.value);
        controller.resetTimer();
       
      }
    : null,

        child: Text(
          isTimerDone
              ? "Resend Code"
              : "Resend in 00:${controller.timeLeft.value.toString().padLeft(2, '0')}",
          style: TextStyle(
            color: isTimerDone ? Colors.green : Colors.white,
            fontSize: 16,
            fontWeight: isTimerDone ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    });
  }
}
