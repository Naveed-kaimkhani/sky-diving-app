// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:sky_diving/components/auth_button.dart';
// import 'package:sky_diving/components/custom_textfield.dart';
// import 'package:sky_diving/components/resend_button.dart';
// import 'package:sky_diving/constants/app_colors.dart';

// class ForgetPassword extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: ()=>Get.back(),
//           child: Icon(Icons.arrow_back, color: Colors.white)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Forget Password", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text("Please type your complete email.  a********@gmail.com", style: TextStyle(color: Colors.white, fontSize: 16)),
//           SizedBox(height: 16),
//               // Input Fields
//               CustomTextField(hintText: "Email Address"),

//                   SizedBox(height: 85),
//           AuthButton(buttonText: "Send Code", onPressed: () {}, isLoading: false.obs),

//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/view_model/auth_controller.dart';

class ForgetPassword extends StatelessWidget {
  final emailController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // Get screen height
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Forget Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Please type your complete email.  a********@gmail.com",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Email Input Field
                  CustomTextField(
                    hintText: "Email Address",
                    controller: emailController,
                  ),

                  // Spacer(), // Pushes the button to the bottom

                  // AuthButton(
                  //   buttonText: "Send Code",
                  //   onPressed: () {
                  //     authController
                  //         .forgotPassword(emailController.text.trim());
                  //   },
                  //   isLoading: authController.isLoading,
                  // ),
                  SizedBox(height: screenHeight * 0.5), // adjust as needed
                  AuthButton(
                    buttonText: "Send Code",
                    onPressed: () {
                      authController
                          .forgotPassword(emailController.text.trim());
                    },
                    isLoading: authController.isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
