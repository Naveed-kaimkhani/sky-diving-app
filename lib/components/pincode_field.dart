
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sky_diving/constants/app_colors.dart';

class PinCodeField extends StatelessWidget {
  const PinCodeField({
    super.key,
    required this.otpControllerField,
  });

  final TextEditingController otpControllerField;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PinCodeTextField(
      length: 6,
      controller: otpControllerField,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: screenSize.height * 0.06,
        fieldWidth: screenSize.width * 0.12,
        inactiveFillColor: const Color.fromARGB(255, 26, 25, 25),
        inactiveColor: Colors.transparent,
        selectedFillColor: Color(0xFF161622),
        selectedColor: AppColors.primaryColor,
        activeFillColor: AppColors.primaryColor,
        activeColor: Colors.black,
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: screenSize.width * 0.06,
        fontWeight: FontWeight.bold,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      appContext: context,
    );
  }
}