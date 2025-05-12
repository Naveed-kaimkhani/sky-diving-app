
import 'package:flutter/material.dart';
import 'package:sky_diving/constants/app_colors.dart';

class SendButton extends StatelessWidget {
  final VoidCallback onSend;

  const SendButton({super.key, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.14; // Adjust size based on screen width
    final iconSize = buttonSize * 0.5;

    return GestureDetector(
      onTap: onSend, // Call the function when tapped
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          // gradient: AppColors.appGradientColors,
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(buttonSize * 0.27),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(buttonSize * 0.14),
          child: Center(
            child: Icon(Icons.send, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
