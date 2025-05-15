import 'package:get/get.dart';
class BottomNavigationController extends GetxController {
  var bottomNavIndex = 0.obs;

  void changeIndex(int index) {
    bottomNavIndex.value = index;
  }
}
