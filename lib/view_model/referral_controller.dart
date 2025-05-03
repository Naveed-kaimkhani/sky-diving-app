import 'dart:async';
import 'package:get/get.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/services/referral_repository.dart';

class ReferralController extends GetxController {
  final ReferralRepository repository;

  ReferralController(this.repository);

  final _referralStreamController = StreamController<ReferralData>.broadcast();
  Stream<ReferralData> get referralStream => _referralStreamController.stream;

  Timer? _timer;

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
    final data = await repository.fetchReferralData();
    if (data != null) {
      _referralStreamController.add(data);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _referralStreamController.close();
    super.onClose();
  }
}
