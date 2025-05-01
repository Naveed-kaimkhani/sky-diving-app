import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sky_diving/services/api_client.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class AuthRepository {
  final ApiClient apiClient = Get.find<ApiClient>();

  final UserController userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException) onFailed,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieval or instant verification
        print("Verification completed: $credential");
        Get.snackbar("Success", "$credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
