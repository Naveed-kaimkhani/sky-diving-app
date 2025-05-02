import 'package:get/get.dart';

class AddCardController extends GetxController {
  RxInt itemCount = 0.obs;

  void increment() {
    itemCount++;
  }

  void decrement() {
    if (itemCount > 0) {
      itemCount--;
    }
  }
}
