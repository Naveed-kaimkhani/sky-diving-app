import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class RedeemSuccessPopup extends StatefulWidget {
  @override
  _RedeemSuccessPopupState createState() => _RedeemSuccessPopupState();
}

class _RedeemSuccessPopupState extends State<RedeemSuccessPopup> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black, // Make dialog background transparent

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.green, width: 3),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Confetti effect behind the thumb
            Positioned.fill(
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Thumb image (replace with your actual asset)
                SvgPicture.asset(
                  'assets/png/like.svg', // Make sure to add this SVG file to your assets
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Successfully Redeem',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Your points redemption request has been sent to the sky diving team — get ready to cash in!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
