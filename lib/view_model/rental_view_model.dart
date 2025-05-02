// rental_view_model.dart
import 'package:get/get.dart';
import 'package:sky_diving/view_model/quantity_controller.dart';

class RentalViewModel extends GetxController {
  final QuantityController quantityController = Get.put(QuantityController());
  
}