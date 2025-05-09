import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/models/referral_data.dart';
import 'package:sky_diving/models/user_model.dart';
import 'package:sky_diving/view_model/referral_controller.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

class UserController extends GetxController {
  late SharedPreferences prefs;
  var showGetStarted = false.obs;
  var token = ''.obs;

  Stream<ReferralData> get referralDataStream => _referralDataController.stream;
  final _referralDataController = StreamController<ReferralData>.broadcast();

  Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getUserFromPrefs(); // Load session on init
  }

  Future<void> saveUserSessionFromResponse(UserModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id ?? 0);
    await prefs.setString('first_name', user.name);
    await prefs.setString('last_name', user.lastName);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', user.phone);

    await prefs.setString('avatar_url', user.proiflePic??"");
    await prefs.setString('square_user_id', user.squareUserId!);
    await prefs.setString('ref_id', user.refId!);
    await prefs.setString('invited_ref_ids', user.invitedRefIds!);
    await prefs.setString('token', token);
  }

  Future<void> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    final name = prefs.getString('first_name');

    final email = prefs.getString('email');
    final phone = prefs.getString('phone');

    final lastName = prefs.getString('last_name');

    final profile = prefs.getString('avatar_url');
    token.value = prefs.getString('token') ?? '';

    showGetStarted.value = token.value.isEmpty;

    final squareUserId = prefs.getString('square_user_id');
    final refId = prefs.getString('ref_id');
    final invitedRefIds = prefs.getString('invited_ref_ids');

    if (id == null ||
        name == null ||
        email == null ||
        phone == null ||
        squareUserId == null ||
        refId == null ||
        invitedRefIds == null) {
      user.value = null; // Set user to null if any data is missing
      return;
    }

    // Create the UserModel object
    UserModel userModel = UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      lastName: lastName ?? "",
      squareUserId: squareUserId,
      refId: refId,
      proiflePic: profile,
      invitedRefIds: invitedRefIds,
    );

    // Assign the loaded user to the reactive user variable
    user.value = userModel;
    log(user.value!.name);
  }

  // You can use the user's info throughout the app as follows:
  UserModel? get currentUser => user.value;

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user.value = null;
    token.value = '';
    showGetStarted.value = true;

    // Delete permanently registered controllers
    Get.delete<ReferralController>();
    Get.delete<UserRewardController>();

    Get.offAllNamed(RouteName.login);
  }
}
