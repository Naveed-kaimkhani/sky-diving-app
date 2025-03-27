
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_routes.dart';
import 'package:sky_diving/view/QRCode_screen/qr_code.dart';
import 'package:sky_diving/view/QRCode_screen/referral_history.dart';
import 'package:sky_diving/view/QRCode_screen/reward_screen.dart';
import 'package:sky_diving/view/home/home_screen.dart';
import 'package:sky_diving/view/profile_screens/profile.dart';
import 'package:sky_diving/view/splash_screen.dart';

void main() {
  //  Get.put(UserController());
  runApp(
MyApp(),
    // DevicePreview(
    //   enabled: true, // Enable DevicePreview for testing
    //   builder: (context) =>  MyApp()
    // ),
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     debugShowCheckedModeBanner: false,
        // debugPaintSizeEnabled = false; // Ensure this is not set to true
  // debugShowMaterialGrid: false,
        theme: ThemeData(
        fontFamily: 'SofiaPro',  // Apply font globally
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'SofiaPro'),
          bodySmall: TextStyle(fontFamily: 'SofiaPro'),
        ),
      ),
      home:SplashScreen(),
      // initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.getAppRoutes(),
    );
  }
}