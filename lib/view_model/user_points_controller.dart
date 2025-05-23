import 'package:get/get.dart';
import 'package:sky_diving/models/user_rewardedpoints.dart';
import 'package:sky_diving/services/reward_repository.dart';
import '../models/user_reward_model.dart';

class UserPointsController extends GetxController {
  var isLoading = true.obs;
  var rewards = <UserPoints>[].obs;
  var error = ''.obs;

  final RewardRepository _rewardRepository = RewardRepository();

  @override
  void onInit() {
    fetchRewards();
    super.onInit();
  }

  void fetchRewards() async {
    try {
      isLoading(true);
      error('');
      final result = await _rewardRepository.fetchUserRewards();
      rewards.assignAll(result);
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
