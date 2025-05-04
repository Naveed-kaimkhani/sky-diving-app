import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sky_diving/view_model/auth_controller.dart';

class QRCodeScanner extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // final AuthController authController = Get.put(AuthController());
  final AuthController authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Referral Code')),
      body: Column(
        children: [
          // Expanded(
          //   flex: 5,
          //   child: QRView(
          //     key: qrKey,
          //     onQRViewCreated: (QRViewController controller) {
          //       controller.scannedDataStream.listen((scanData) {
          //         if (scanData.code != null && authController.referralCode.value.isEmpty) {
          //           authController.referralCode.value = scanData.code!;
          //           controller.pauseCamera();
          //           Get.back(); // close scanner screen
          //         }
          //       });
          //     },
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Obx(() => Center(
                  child: Text(authController.referralCode.value.isEmpty
                      ? 'Scan a referral QR code'
                      : 'referral: ${authController.referralCode.value}'),
                )),
          ),
        ],
      ),
    );
  }
}
