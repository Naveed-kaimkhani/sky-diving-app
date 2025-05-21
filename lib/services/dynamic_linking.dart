import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_diving/utils/app_strings.dart';
import 'package:sky_diving/view_model/auth_controller.dart';


class DynamicLinkProvider {
  final AuthController authController = Get.put(AuthController());

  Future<String> createLink({required String refCode}) async {
  final String deepLink =
      "https://skydivingrentalgear.com/?refId=$refCode";

  final DynamicLinkParameters parameters = DynamicLinkParameters(
    androidParameters: const AndroidParameters(
      packageName: AppStrings.APP_PACKAGE_NAME,
      minimumVersion: AppStrings.ANDROID_MINIMUM_VERSION,
    ),
    iosParameters: IOSParameters(
      bundleId: AppStrings.APP_BUNDLE_ID,
      minimumVersion: AppStrings.IOS_MINIMUM_VERSION,
      appStoreId: '6743659100',
      fallbackUrl: Uri.parse('https://apps.apple.com/pk/app/sky-diving-app/id6743659100'),
    ),
    link: Uri.parse(deepLink),
    uriPrefix: AppStrings.DYNAMIC_URL,
  );

  final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
  final refLink = await link.buildShortLink(parameters);
  return refLink.shortUrl.toString();
}


  /// Initialize dynamic link
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    ///this will call when app is in foreground
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK

      // Ex: product/013232
      if (deepLink.isEmpty) return;
      handleDeepLink(queryParam: dynamicLinkData.link.queryParameters);
    }).onError((error) {});

    ///this will call when app is in killed state
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if (initialLink == null) return;
      handleDeepLink(queryParam: initialLink.link.queryParameters);
    } catch (e) {
      print("error is $e");
    }
  }

  void handleDeepLink({Map<String, dynamic>? queryParam}) async {
    if (queryParam != null) {
      final refId = queryParam['refId'];
     
      authController.referralCode.value = refId;

      // Store in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('referral_code', refId);
      
    }
  }
}
