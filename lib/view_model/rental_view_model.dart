// rental_view_model.dart
import 'package:get/get.dart';
import 'package:sky_diving/view_model/quantity_controller.dart';

import '../models/add_card_model.dart';

class RentalViewModel extends GetxController {
  final QuantityController quantityController = Get.put(QuantityController());
RxInt cost = 70.obs; // <-- Changed
  Rx<AddCardModel> addCardModel = AddCardModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setAddCard();
  }
  void cardOnj(){
    addCardModel.value.quantity=quantityController.quantity.value.toString();
  }
 void setAddCard(){
   addCardModel.value = AddCardModel(
       dateOfFirst: "",
       deliveryOption:"Pickup at longmont Co location",
       rentalPeriod:"Daily rental",
       Canopy:"Spectre 150",
       quantity:quantityController.quantity.value.toString()
   );
 }
// Other rental-related state and business logic would go here
  // For example:
  // - Selected rental options
  // - Date selection
  // - Delivery options
  // - Form validation
  // - API calls
}