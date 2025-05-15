import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/services/support_repo.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class SupportController extends GetxController {
  final SupportRepo supportRepo;

  final UserController userController = Get.find<UserController>();
  SupportController({required this.supportRepo});

  var isLoading = false.obs;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  RxList<File> selectedFiles = <File>[].obs;

  void pickFile(File file) {
    selectedFiles.add(file);
  }

  void removeFile(File file) {
    selectedFiles.remove(file);
  }

  Future<void> submitSupportForm(int userId) async {
    final title = titleController.text.trim();
    final desc = descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields",
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    final result = await supportRepo.sendSupportMail(
      userId: userId,
      title: title,
      description: desc,
      token: userController.token.value,
      files: selectedFiles.isEmpty ? null : selectedFiles,
    );
    isLoading.value = false;

    if (result['success']) {
      Get.snackbar("Success", "Support email sent!", colorText: Colors.white);
      titleController.clear();
      descController.clear();
      selectedFiles.clear();
    } else {
      Get.snackbar(
          "Error", result["data"]?["message"] ?? "Something went wrong",
          colorText: Colors.white);
    }
  }
}
