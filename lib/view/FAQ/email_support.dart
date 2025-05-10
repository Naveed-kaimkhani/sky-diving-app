// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sky_diving/components/auth_button.dart';
// import 'package:sky_diving/components/custom_textfield.dart';
// import 'package:sky_diving/components/file_picker_widget.dart';
// import 'package:sky_diving/components/title_appbar.dart';
// import 'package:sky_diving/services/support_repo.dart';
// import 'package:sky_diving/view_model/support_controller.dart';
// import 'package:sky_diving/view_model/user_controller.dart';

// // class EmailSupportScreen extends StatefulWidget {
// //   @override
// //   State<EmailSupportScreen> createState() => _EmailSupportScreenState();
// // }

// // class _EmailSupportScreenState extends State<EmailSupportScreen> {
// //   late final SupportController controller;

// //   final int userId = 27;

// //   @override
// //   void initState() {
// //     super.initState();
// //     controller = Get.put(SupportController(supportRepo: SupportRepo()));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     final padding = size.width * 0.03;
// //     final verticalSpacing = size.height * 0.01;
// //     final titleFontSize = size.width * 0.042;

// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: TitleAppBar(
// //         showSubTitle: true,
// //         onBackPressed: () => Get.back(),
// //         title: "Email to Support",
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(padding),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _label("Title", titleFontSize),
// //             SizedBox(height: verticalSpacing),
// //             CustomTextField(
// //               hintText: "Enter Title",
// //               controller: controller.titleController,
// //             ),
// //             SizedBox(height: verticalSpacing * 1.6),
// //             _label("Description", titleFontSize),
// //             SizedBox(height: verticalSpacing),
// //             CustomTextField(
// //               hintText: "Write Something....",
// //               controller: controller.descController,
// //             ),
// //             SizedBox(height: verticalSpacing * 1.6),
// //             _label("Attach Files & Links ( Optional )", titleFontSize),
// //             SizedBox(height: verticalSpacing),
// //             FilePickerWidget(
// //               onFileSelected: controller.pickFile,
// //             ),
// //             Obx(() => Wrap(
// //               spacing: 8,
// //               children: controller.selectedFiles.map((file) {
// //                 return Chip(
// //                   label: Text(file.path.split('/').last),
// //                   deleteIcon: Icon(Icons.close, size: 16),
// //                   onDeleted: () => controller.removeFile(file),
// //                   backgroundColor: Colors.white24,
// //                   labelStyle: TextStyle(color: Colors.white),
// //                 );
// //               }).toList(),
// //             )),
// //             SizedBox(height: verticalSpacing * 3),
// //             Obx(() => AuthButton(
// //               buttonText: "Submit",
// //               onPressed: () => controller.submitSupportForm(userId),
// //               isLoading: controller.isLoading,
// //             )),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _label(String text, double fontSize) => Text(
// //     text,
// //     style: TextStyle(color: Colors.white, fontSize: fontSize),
// //   );
// // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/file_picker_widget.dart';
import 'package:sky_diving/components/title_appbar.dart';

class EmailSupportScreen extends StatefulWidget {
  @override
  _EmailSupportScreenState createState() => _EmailSupportScreenState();
}

class _EmailSupportScreenState extends State<EmailSupportScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;

    // Calculate responsive values
    final padding = size.width * 0.03; // ~10dp on average screens
    final verticalSpacing = size.height * 0.01; // Responsive vertical spacing
    final titleFontSize = size.width * 0.042; // Responsive font size

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        showSubTitle: true,
        onBackPressed: () => Get.back(),
        title: "Email to Support",
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: verticalSpacing),
            CustomTextField(hintText: "Enter Title"),

            SizedBox(height: verticalSpacing * 1.6), // Slightly larger spacing
            Text(
              "Description",
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
              ),
            ),

            SizedBox(height: verticalSpacing),
            CustomTextField(hintText: "Write Something...."),

            SizedBox(height: verticalSpacing * 1.6),
            Text(
              "Attach Files & Links ( Optional )",
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
              ),
            ),

            SizedBox(height: verticalSpacing),
            FilePickerWidget(),
            SizedBox(
                height: verticalSpacing * 3), // Larger spacing before button
            AuthButton(
              buttonText: "Submit",
              onPressed: () {},
              isLoading: false
                  .obs, // Make sure your AuthButton accepts height parameter
            ),
          ],
        ),
      ),
    );
  }
}
