import 'package:flutter/material.dart';

class ScanQRCodeButton extends StatelessWidget {
  const ScanQRCodeButton({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.screenSize,
  });

  final double buttonWidth;
  final double buttonHeight;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 26, 25, 25),
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.015,
            horizontal: screenSize.width * 0.04,
          ),
               shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              // side: BorderSide(color: Colors.grey.shade300), // Optional: Add a border if needed
            ),
        ),
        onPressed: () {},
        child: Text(
          "Scan QR Code",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenSize.width * 0.05,
          ),
        ),
      ),
    );
  }
}
