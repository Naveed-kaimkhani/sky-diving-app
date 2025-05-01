import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sky_diving/constants/app_colors.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final RxBool isLoading;

  const AuthButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.059;
    final buttonWidth = screenSize.width * 0.9;
    final fontSize = screenSize.width * 0.048;
    final spinnerSize = screenSize.width * 0.06;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Obx(() => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.015,
                  horizontal: screenSize.width * 0.04),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // side: BorderSide(color: Colors.grey.shade300), // Optional: Add a border if needed
              ),
            ),
            onPressed: onPressed,
            child: isLoading.value
                ? SpinKitFadingCircle(color: Colors.black, size: spinnerSize)
                : Text(
                    buttonText,
                    style: TextStyle(color: Colors.black, fontSize: fontSize),
                  ),
          )),
    );
  }
}
