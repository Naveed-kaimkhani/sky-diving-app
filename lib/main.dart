import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_routes.dart';
import 'package:sky_diving/firebase_options.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/services/auth_respository.dart';
import 'package:sky_diving/services/referral_repository.dart';
import 'package:sky_diving/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  // await FlutterBranchSdk.init(enableLogging: false, disableTracking: false);
 await FlutterBranchSdk.init().then((value) {
   FlutterBranchSdk.validateSDKIntegration();
 });
    initBranchSdk(); // Start listening

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ApiClient());
  Get.put(AuthRepository());
  Get.put(ReferralRepository());
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
      // home: ChangePassword(),

      home: SplashScreen(),

      // initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.getAppRoutes(),
    );
  }

}
void initBranchSdk() {
  FlutterBranchSdk.listSession().listen((data) {
    if (data.containsKey('+clicked_branch_link') && data['+clicked_branch_link'] == true) {
      // Handle the deep link data
      print('Deep Link Data: ${data}');
      final String? route = data['~referring_link'];
      // You can parse or use any custom key-value you passed into your Branch link
    } else {
      print('No deep link data or link not clicked');
    }
  });
}


