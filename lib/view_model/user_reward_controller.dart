// user_reward_controller.dart
import 'package:get/get.dart';
import 'package:sky_diving/models/user_reward_model.dart';
import 'package:sky_diving/services/referral_repository.dart';
class UserRewardController extends GetxController {
  final ReferralRepository _repository = Get.find<ReferralRepository>();
  final RxBool isLoading = false.obs;
  final RxList<UserReward> rewards = <UserReward>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchUserRewards(String token) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final response = await _repository.getUserRewards(token);
      
      if (response != null) {
        rewards.assignAll(response.data);
      } else {
        error.value = 'Failed to load rewards';
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}