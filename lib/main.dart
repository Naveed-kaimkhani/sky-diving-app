
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_routes.dart';
import 'package:sky_diving/navigation_bar.dart';
import 'package:sky_diving/view/FAQ/email_support.dart';
import 'package:sky_diving/view/home/rental_screen.dart';
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
  fontFamily: 'Gilroy', // Apply Gilroy globally
  textTheme: TextTheme(
    bodyMedium: TextStyle(fontFamily: 'Gilroy'),
    bodySmall: TextStyle(fontFamily: 'Gilroy'),
  ),
),
      home: SplashScreen(),
      // initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.getAppRoutes(),
    );
  }
} 