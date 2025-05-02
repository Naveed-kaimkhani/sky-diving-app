// rental_view_model.dart
import 'package:get/get.dart';
import 'package:sky_diving/view_model/quantity_controller.dart';

import '../models/add_card_model.dart';

class RentalViewModel extends GetxController {
  final QuantityController quantityController = Get.put(QuantityController());

  Rx<AddCardModel> addCardModel = AddCardModel().obs;
  void cardOnj(){
    addCardModel.value.quantity=quantityController.quantity.value.toString();
  }

// Other rental-related state and business logic would go here
  // For example:
  // - Selected rental options
  // - Date selection
  // - Delivery options
  // - Form validation
  // - API calls
}