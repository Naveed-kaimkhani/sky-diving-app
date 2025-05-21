import 'package:get/get.dart';
import 'package:sky_diving/chat_screen/chat_screen.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/navigation_bar.dart';
import 'package:sky_diving/view/FAQ/contact_info_screen.dart';
import 'package:sky_diving/view/FAQ/email_support.dart';
import 'package:sky_diving/view/FAQ/faq_screen.dart';
import 'package:sky_diving/view/FAQ/terms_and_privacy.dart';
import 'package:sky_diving/view/QRCode_screen/qr_code.dart';
import 'package:sky_diving/view/QRCode_screen/referral_history.dart';
import 'package:sky_diving/view/QRCode_screen/reward_screen.dart';
import 'package:sky_diving/view/add_order/coupons_screen.dart';
import 'package:sky_diving/view/add_order/web_view.dart';
import 'package:sky_diving/view/auth_screens/change_password.dart';
import 'package:sky_diving/view/auth_screens/forget_password.dart';
import 'package:sky_diving/view/auth_screens/login_screen.dart';
import 'package:sky_diving/view/auth_screens/signup_screen.dart';
import 'package:sky_diving/view/auth_screens/verify_otp.dart';
import 'package:sky_diving/view/home/rental_screen.dart';
import 'package:sky_diving/view/notification_screen/notification_screen.dart';
import 'package:sky_diving/view/profile_screens/profile.dart';
import 'package:sky_diving/view/profile_screens/update_profile.dart';
import 'package:sky_diving/view/splash_screen.dart';

import '../view/check_out/check_out.dart';

class AppRoutes {
  static getAppRoutes() => [
        GetPage(
            name: RouteName.signup,
            page: () => SignupScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.mainPage,
            page: () => WebView(),
            transition: Transition.cupertino),
              GetPage(
            name: RouteName.chatScreen,
            page: () => GroupChatScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.qrCode,
            page: () => QrCode(),
            transition: Transition.cupertino),
       
        GetPage(
            name: RouteName.checkOut,
            page: () => CheckOut(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.emailSupportScreen,
            page: () => EmailSupportScreen(),
            transition: Transition.cupertino),
   
                    GetPage(
            name: RouteName.contactInfoScreen,
            page: () => ContactInfoScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.referralHistory,
            page: () => ReferralHistory(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.qrCode,
            page: () => QrCode(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.notificationsScreen,
            page: () => NotificationsScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.rentalScreen,
            page: () => RentalScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.fAQScreen,
            page: () => FAQScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.bottomNavigation,
            page: () => BottomNavigation(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.updateProfile,
            page: () => UpdateProfile(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.termsAndPrivacyScreen,
            page: () => TermsAndPrivacyScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.profileScreen,
            page: () => ProfileScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.rewardScreen,
            page: () => RewardScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.splashScreen,
            page: () => SplashScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.login,
            page: () => LoginScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.couponsScreen,
            page: () => CouponsScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.changePassword,
            page: () => ChangePassword(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.forgetPassword,
            page: () => ForgetPassword(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.splashScreen,
            page: () => SplashScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: RouteName.oTPScreen,
            page: () => OTPScreen(),
            transition: Transition.cupertino),
      ];
}
