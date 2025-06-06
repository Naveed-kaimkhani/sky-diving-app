import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/file_picker_widget.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/services/support_repo.dart';
import 'package:sky_diving/view_model/support_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';

class EmailSupportScreen extends StatefulWidget {
  @override
  State<EmailSupportScreen> createState() => _EmailSupportScreenState();
}

class _EmailSupportScreenState extends State<EmailSupportScreen> {


  final UserController userController = Get.find<UserController>();

  final SupportController controller =
      Get.put(SupportController(supportRepo: SupportRepo()));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.03;
    final verticalSpacing = size.height * 0.01;
    final titleFontSize = size.width * 0.042;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        showSubTitle: true,
        onBackPressed: () => Get.back(),
        title: "Email to Support",
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Title", titleFontSize),
              SizedBox(height: verticalSpacing),
              CustomTextField(
                hintText: "Enter Title",
                controller: controller.titleController,
              ),
              SizedBox(height: verticalSpacing * 1.6),
              _label("Description", titleFontSize),
              SizedBox(height: verticalSpacing),
              CustomTextField(
                hintText: "Write Something....",
                controller: controller.descController,
              ),
              SizedBox(height: verticalSpacing * 1.6),
              _label("Attach Files & Links ( Optional )", titleFontSize),
              SizedBox(height: verticalSpacing),
              FilePickerWidget(
                onFileSelected: controller.pickFile,
              ),
              Obx(() => Wrap(
                    spacing: 8,
                    children: controller.selectedFiles.map((file) {
                      return Chip(
                        label: Text(file.path.split('/').last),
                        deleteIcon: Icon(Icons.close, size: 16),
                        onDeleted: () => controller.removeFile(file),
                        backgroundColor: Colors.white24,
                        labelStyle: TextStyle(color: Colors.white),
                      );
                    }).toList(),
                  )),
              SizedBox(height: verticalSpacing * 3),
          Center(
  child: AuthButton(
    buttonText: "Submit",
    onPressed: () {
      FocusScope.of(context).unfocus(); // ⬅️ Dismiss keyboard
      controller.submitSupportForm(userController.user.value!.id ?? 0);
    },
    isLoading: controller.isLoading,
  ),
)
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, double fontSize) => Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      );
}
