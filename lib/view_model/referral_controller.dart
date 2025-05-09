import 'dart:async';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/services/referral_repository.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class ReferralController extends GetxController {
  final ReferralRepository repository = ReferralRepository();
  final UserController userController = Get.find<UserController>();

  Rxn<ReferralData> referralData = Rxn<ReferralData>(); // nullable Rx

  Future<void> fetchReferralData() async {
 
    final data = await repository.fetchReferralData(userController.token.value);
    if (data != null) {
      referralData.value = data;
    }
  }
}
