// First, create a controller for the quantity
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sky_diving/view_model/rental_view_model.dart';

class QuantityController extends GetxController {
  var quantity = 1.obs;

  // final viewModel = Get.find<RentalViewModel>();
  final viewModel = Get.put(RentalViewModel());

  void increment() {
    quantity.value++;

    viewModel.cost.value * quantity.value;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;

      viewModel.cost.value * quantity.value;
    }
  }
}

// Then in your widget:
