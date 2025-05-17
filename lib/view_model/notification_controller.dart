import 'package:get/get.dart';
import 'package:sky_diving/models/notification_model.dart';
import 'package:sky_diving/services/notification_repository.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class NotificationController extends GetxController {
  final NotificationRepository notificationRepository = NotificationRepository();

  final UserController userController = Get.find<UserController>();
  RxBool isLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  void fetchNotifications() async {
    try {
      isLoading(true);
      final response = await notificationRepository.fetchNotifications(userController.token.value);
      notifications.value = response.map((json) => NotificationModel.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
