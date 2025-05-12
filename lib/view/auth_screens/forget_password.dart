
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sky_diving/components/auth_button.dart';
// import 'package:sky_diving/components/custom_textfield.dart';
// import 'package:sky_diving/components/phone_number_field.dart';
// import 'package:sky_diving/view_model/auth_controller.dart';

// class ForgetPassword extends StatelessWidget {
//   final emailController = TextEditingController();
//   final authController = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight =
//         MediaQuery.of(context).size.height; // Get screen height
//     double screenWidth = MediaQuery.of(context).size.width; // Get screen width

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Get.back(),
//           child: Icon(Icons.arrow_back_ios, color: Colors.white),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: screenHeight,
//             ),
//             child: IntrinsicHeight(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: screenHeight * 0.02),
//                   Text(
//                     "Forget Password",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   Text(
//                     "Please type your phone number. \n+19723******",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   SizedBox(height: screenHeight * 0.03),

//                   // Email Input Field
//                   PhoneNumberField(
//                     onPhoneChanged: (value) {
//                       // emailController.text = value;
//                       authController.phoneNumber.value = value;
//                     },
//                   ),
//                   SizedBox(height: screenHeight * 0.5), // adjust as needed
//                   AuthButton(
//                     buttonText: "Send Code",
//                     onPressed: () {
//                       authController.sendOtp(authController.phoneNumber.value,
//                           isComingFromForgetPassword: true);
//                     },
//                     isLoading: authController.isLoading,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/phone_number_field.dart';
import 'package:sky_diving/view_model/auth_controller.dart';

class ForgetPassword extends StatelessWidget {
  final emailController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; // Get screen height
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
      resizeToAvoidBottomInset: true, // Allows the screen to resize when the keyboard appears
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Adds padding equal to keyboard height
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
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
                      "Please type your phone number. \n+19723******",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Phone Number Input Field
                    PhoneNumberField(
                      onPhoneChanged: (value) {
                        authController.phoneNumber.value = value;
                      },
                    ),
                    Spacer(), // Pushes the button to the bottom
                    AuthButton(
                      buttonText: "Send Code",
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        authController.sendOtp(authController.phoneNumber.value,
                            isComingFromForgetPassword: true);
                      },
                      isLoading: authController.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
