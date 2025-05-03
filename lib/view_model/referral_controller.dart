import 'dart:async';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/services/referral_repository.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class ReferralController extends GetxController {
  final ReferralRepository repository = ReferralRepository();
  final UserController userController = Get.find<UserController>();

  final _referralStreamController = StreamController<ReferralData>.broadcast();
  Stream<ReferralData> get referralStream => _referralStreamController.stream;

  Timer? _timer;
  bool _isClosed = false;

  @override
  void onInit() {
    super.onInit();
    _startFetching();
  }

  void _startFetching() {
    _fetchOnce();
    _timer = Timer.periodic(Duration(seconds: 10), (_) => _fetchOnce());
  }

  void _fetchOnce() async {
    final data = await repository.fetchReferralData(userController.token.value);
    if (data != null && !_isClosed) {
      _referralStreamController.add(data);
    }
  }

  @override
  void onClose() {
    _isClosed = true;
    _timer?.cancel();
    _referralStreamController.close();
    super.onClose();
  }
}
