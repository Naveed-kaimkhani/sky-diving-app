import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class ReferralServices {
  /// Generates a short dynamic link with a referral code.
  static Future<Uri> createReferralLink(String referralCode) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://skydivingrentalgear.page.link',
      link: Uri.parse('https://skydivingrentalgear.page.link'),
      iosParameters: IOSParameters(
        bundleId: 'com.zaygon.skydiving',
        appStoreId: '6743659100',
        minimumVersion: '1.0.0',
      ),
    );

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return shortLink
        .shortUrl; // Returns something like skydiving.page.link/abc123
  }

  /// Called when a dynamic link is detected
  static void _handleDeepLink(Uri deepLink) {
    final referralCode = deepLink.queryParameters['ref'];
    if (referralCode != null) {
    
    }
  }

  /// Call this once when app starts (e.g. SplashScreen)
  static Future<void> initDynamicLinks() async {
    try {
      // Check if app was opened from a terminated state
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();

      if (initialLink?.link != null) {
        _handleDeepLink(initialLink!.link);
      }

      // Listen when app is in background or foreground
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        _handleDeepLink(dynamicLinkData.link);
      }).onError((error) {
        print('❌ Error in dynamic link: $error');
      });
    } catch (e) {
      print('❌ initDynamicLinks exception: $e');
    }
  }
}
