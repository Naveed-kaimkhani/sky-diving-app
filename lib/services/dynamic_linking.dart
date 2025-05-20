import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:sky_diving/utils/app_strings.dart';
import 'package:sky_diving/view_model/auth_controller.dart';

//Firebase Dynamic link
//https://retrorides.page.link

class DynamicLinkProvider {
  final AuthController authController = Get.put(AuthController());
  Future<String> createLink({required String refCode}) async {
    // final String url =
    //     "${AppStrings.DYNAMIC_URL}?${AppStrings.POST_ID}=$postId&${AppStrings.POST_INDEX}=$postIndex";
    // final String deepLink = "https://skydivingrentalgear.com/$refCode";
    final String deepLink =
        "https://skydivingrentalgear.com/?refId=$refCode"; //"https://skydivingrentalgear.com/ref-$refCode";

    // final String url = "${AppStrings.DYNAMIC_URL}?$refCode"; // Yaha add karwao
    // const String url = AppStrings.DYNAMIC_URL;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: AppStrings.APP_PACKAGE_NAME,
            minimumVersion: AppStrings.ANDROID_MINIMUM_VERSION),
        iosParameters: IOSParameters(
          bundleId: AppStrings.APP_BUNDLE_ID,
          minimumVersion: AppStrings.IOS_MINIMUM_VERSION,
          appStoreId: AppStrings.APP_STORE_ID,
          fallbackUrl: Uri(
            scheme: 'https',
            host: 'play.google.com',
            path: '/store/apps/details',
            queryParameters: {'id': 'com.example.app'},
          ),
        ),
        link: Uri.parse(deepLink),
        uriPrefix: AppStrings.DYNAMIC_URL);
    final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  /// Initialize dynamic link
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    ///this will call when app is in foreground
    dynamicLinks.onLink.listen((dynamicLinkData) {
      // AppDialogs.showToast(message: "from forgound state");
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK

      // Ex: product/013232
      if (deepLink.isEmpty) return;
      handleDeepLink(queryParam: dynamicLinkData.link.queryParameters);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

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
    print('queryParam');
    print(queryParam);
    // print(queryParam![AppStrings.POST_ID]);
    if (queryParam != null) {
      log("queryParam: ${queryParam}");
      final refId = queryParam['refId'];
      log("queryParam: $queryParam");
      log("refId: $refId");

      authController.referralCode.value = refId;
      log("id from controller $refId");
    }
  }
}
