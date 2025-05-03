import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_routes.dart';
import 'package:sky_diving/firebase_options.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/auth_respository.dart';
import 'package:sky_diving/view/auth_screens/login_screen.dart';
import 'package:sky_diving/view/auth_screens/signup_screen.dart';
import 'package:sky_diving/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(ApiClient());

  Get.put(AuthRepository());
  runApp(MyApp());
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
      // home: SplashScreen(),

      home: LoginScreen(),

      // initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.getAppRoutes(),
    );
  }
}
