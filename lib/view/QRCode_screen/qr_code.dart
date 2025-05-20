import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sky_diving/components/appbar_with_backicon.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/services/referral_services.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class QrCode extends StatelessWidget {
  QrCode({super.key});

  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final shortestSide = screenSize.shortestSide;

    // Define breakpoints for different screen sizes
    final bool isSmallScreen = shortestSide < 400;
    final bool isMediumScreen = shortestSide >= 400 && shortestSide < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWithBackicon(
        username: userController.user.value!.name,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen
                ? 16.0
                : isMediumScreen
                    ? 24.0
                    : 32.0,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenSize.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelText(
                            text: "Your Unique Referral Code",
                            fontSize: isSmallScreen ? 16 : 18,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      SizedBox(
                        width: shortestSide * 0.8,
                        height: shortestSide * 0.8,
                        child: QrImageView(
                          data: userController.user.value!.refId ??
                              "", // or use your dynamic value
                          version: QrVersions.auto,
                          size: shortestSide * 0.8,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: isSmallScreen ? 16.0 : 24.0,
                      top: screenSize.height * 0.035,
                    ),
                    child: AuthButton(
                      buttonText: "Share QR Code",
                      // onPressed: () async {
                      //   ReferralServices.createReferralLink(
                      //       userController.user.value!.refId ?? "");


                      //   // final box = context.findRenderObject() as RenderBox?;
                      //   // final code =
                      //   //     userController.user.value?.refId ?? 'NO-CODE';
                      //   // final message =
                      //   //     "Hey! Use my Sky Diving referral code: $code 🪂";

                      //   // await SharePlus.instance.share(
                      //   //   ShareParams(
                      //   //     text: message,
                      //   //     subject: "Join Sky Diving App!",
                      //   //     sharePositionOrigin:
                      //   //         box!.localToGlobal(Offset.zero) & box.size,
                      //   //   ),
                      //   // );
                      // },

                      onPressed: () async {
  final refId = userController.user.value?.refId ?? 'NO-CODE';

  try {
    final Uri dynamicLink = await ReferralServices.createReferralLink(refId);

    final box = context.findRenderObject() as RenderBox?;
    final message =
        "Hey! Use my Sky Diving referral link to join: $dynamicLink 🪂";

    await Share.share(
      message,
      subject: "Join Sky Diving App!",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  } catch (e) {
    print("❌ Error generating referral link: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to generate referral link")),
    );
  }
},


                      isLoading: false.obs,
                      // width: screenSize.width * 0.9, // Responsive button width
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
