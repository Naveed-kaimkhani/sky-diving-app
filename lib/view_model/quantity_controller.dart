// First, create a controller for the quantity
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuantityController extends GetxController {
  var quantity = 1.obs;
  
  void increment() {
    quantity.value++;
  }
  
  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}

// Then in your widget:
