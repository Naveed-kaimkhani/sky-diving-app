
import 'package:get/get.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/view/auth_screens/change_password.dart';
import 'package:sky_diving/view/auth_screens/forget_password.dart';
import 'package:sky_diving/view/auth_screens/login_screen.dart';
import 'package:sky_diving/view/auth_screens/signup_screen.dart';
import 'package:sky_diving/view/auth_screens/verify_otp.dart';
import 'package:sky_diving/view/splash_screen.dart';



class AppRoutes {
  static getAppRoutes() => [
    GetPage(
        name: RouteName.signup,
        page: () =>  SignupScreen(),
        transition: Transition.cupertino),
          GetPage(
        name: RouteName.splashScreen,
        page: () =>  SplashScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: RouteName.login,
        page: () =>  LoginScreen(),
        transition: Transition.cupertino),
            GetPage(
        name: RouteName.changePassword,
        page: () =>  ChangePassword(),
        transition: Transition.cupertino),
           GetPage(
        name: RouteName.forgetPassword,
        page: () =>  ForgetPassword(),
        transition: Transition.cupertino),
            GetPage(
        name: RouteName.splashScreen,
        page: () =>  SplashScreen(),
        transition: Transition.cupertino),
                    GetPage(
        name: RouteName.oTPScreen,
        page: () =>  OTPScreen(),
        transition: Transition.cupertino),
  ];
}