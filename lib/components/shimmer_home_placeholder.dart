import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomePlaceholder extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const ShimmerHomePlaceholder({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            _buildCardShimmer(),
            SizedBox(height: screenHeight * 0.02),
            _buildCardShimmer(),
            SizedBox(height: screenHeight * 0.02),
            _buildCardShimmer(),
            SizedBox(height: screenHeight * 0.02),
            _buildCardShimmer(),
            SizedBox(height: screenHeight * 0.02),
            _buildCardShimmer(),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildReferralCardShimmer(screenWidth),
                  _buildReferralCardShimmer(screenWidth),
                  _buildReferralCardShimmer(screenWidth),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonShimmer(screenWidth),
                _buildButtonShimmer(screenWidth),
              ],
            ),
            SizedBox(height: screenHeight * 0.12),
          ],
        ),
      ),
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildWideCardShimmer() {
    return Container(
      width: screenWidth * 0.56,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildReferralCardShimmer(double screenWidth) {
    return Container(
      width: screenWidth * 0.27,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildButtonShimmer(double screenWidth) {
    return Container(
      width: screenWidth * 0.4,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
