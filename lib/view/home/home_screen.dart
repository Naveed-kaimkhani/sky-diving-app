// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sky_diving/components/custom_button.dart';
// import 'package:sky_diving/components/line_chart.dart';
// import 'package:sky_diving/components/navigation_button.dart';
// import 'package:sky_diving/components/referral_card.dart';
// import 'package:sky_diving/components/reward_balance_card.dart';
// import 'package:sky_diving/constants/app_svg_icons.dart';
// import 'package:sky_diving/components/custom_AppBar.dart';
// import 'package:sky_diving/constants/routes_name.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final isSmallScreen = screenWidth < 400;

//     return Scaffold(
//       backgroundColor: Colors.black, // Dark background color
//       appBar: CustomAppBar(username: "Jaydon Bator", profileImage: AppSvgIcons.profile),
//       body: Padding(
//         padding: EdgeInsets.only(
//           left: isSmallScreen ? 10.0 : 20.0,
//           right: isSmallScreen ? 10.0 : 20.0,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 AppSvgIcons.poster,
//                 height: screenHeight * 0.25,
//                 width: screenWidth * 0.9,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               CustomButton(
//                 onPressed: () {},
//                 text: "Contact Us for More Information",
//                 width: screenWidth * 0.9,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               CustomButton(
//                 onPressed: () {},
//                 text: "Order Your Rental Now",
//                 width: screenWidth * 0.9,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               RewardBalanceCard(
//                 height: screenHeight * 0.08,
//                 width: screenWidth * 0.56,
//                 balance: "\$50.00",
//                 coinImage: AppSvgIcons.coin,
//                 confettiImage: AppSvgIcons.confettiImage,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               GestureDetector(
//                 onTap: ()=>Get.toNamed(RouteName.qrCode ),
//                 child: RewardBalanceCard(
//                   width: screenWidth * 0.18,
//                   height: screenHeight * 0.08,
//                   rewardText: "Scan to Refer a Friend",
//                   balance: "3 Completed",
//                   coinImage: null,
//                   confettiImage: AppSvgIcons.scan,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ReferralCard(
//                     count: "3",
//                     text: "Total Referrals",
//                     width: screenWidth * 0.27,
//                   ),

//               SizedBox(width: screenHeight * 0.01),
//                   ReferralCard(
//                     count: "34",
//                     text: "Active Referrals",
//                     width: screenWidth * 0.27,
//                   ),

//               SizedBox(width: screenHeight * 0.01),
//               // SizedBox(width: screenHeight * 0.02),
//                   ReferralCard(
//                     count: "\$120",
//                     text: "Reward Earned",
//                     width: screenWidth * 0.27,
//                   ),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               LineChartSample2(),
//               // SizedBox(height: screenHeight * 0.02),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   NavigationButton(
//                     text: "FAQs",
//                     onPressed: () {},
//                     width: screenWidth * 0.4,
//                   ),
//                   NavigationButton(
//                     text: "Help & Support",
//                     onPressed: () {},
//                     width: screenWidth * 0.4,
//                   ),

//               SizedBox(height: screenHeight * 0.12),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/navigation_button.dart';
import 'package:sky_diving/components/referral_card.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black, // Dark background color
      appBar: CustomAppBar(
          username: "Jaydon Bator", profileImage: AppSvgIcons.profile),
      body: Padding(
        padding: EdgeInsets.only(
          left: isSmallScreen ? 10.0 : 20.0,
          right: isSmallScreen ? 10.0 : 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () => Get.toNamed(RouteName.qrCode),
                child: RewardBalanceCard(
                  width: screenWidth * 0.18,
                  height: screenHeight * 0.08,
                  rewardText: "Scan to Refer a Friend",
                  balance: "3 Completed",
                  coinImage: null,
                  confettiImage: AppSvgIcons.scan,
                ),
              ),
              // Image.asset(
              //   AppSvgIcons.poster,
              //   height: screenHeight * 0.25,
              //   width: screenWidth * 0.9,
              //   fit: BoxFit.contain,
              // ),
              SizedBox(height: screenHeight * 0.02),
              // CustomButton(
              //   onPressed: () {},
              //   text: "Contact Us for More Information",
              //   width: screenWidth * 0.9,
              // ),
              RewardBalanceCard(
                width: screenWidth * 0.18,
                height: screenHeight * 0.08,
                rewardText: "Contact Us for ",
                balance: "More Information",
                coinImage: null,
                confettiImage: null,
              ),
              SizedBox(height: screenHeight * 0.02),
              // CustomButton(
              //   onPressed: () {},
              //   text: "Contact Us for More Information",
              //   width: screenWidth * 0.9,
              // ),
              RewardBalanceCard(
                onTap: () => Get.toNamed(RouteName.rentalScreen),
                width: screenWidth * 0.18,
                height: screenHeight * 0.08,
                rewardText: "Order Your Rental ",
                balance: "Now",
                coinImage: null,
                confettiImage: null,
              ),
              SizedBox(height: screenHeight * 0.02),
              RewardBalanceCard(
                height: screenHeight * 0.08,
                width: screenWidth * 0.56,
                balance: "\$50.00",
                coinImage: AppSvgIcons.coin,
                confettiImage: AppSvgIcons.confettiImage,
              ),
              SizedBox(height: screenHeight * 0.02),
              // GestureDetector(
              //   onTap: () => Get.toNamed(RouteName.qrCode),
              //   child: RewardBalanceCard(
              //     width: screenWidth * 0.18,
              //     height: screenHeight * 0.08,
              //     rewardText: "Scan to Refer a Friend",
              //     balance: "3 Completed",
              //     coinImage: null,
              //     confettiImage: AppSvgIcons.scan,
              //   ),
              // ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReferralCard(
                    count: "3",
                    text: "Total Referrals",
                    width: screenWidth * 0.27,
                  ),

                  SizedBox(width: screenHeight * 0.01),
                  ReferralCard(
                    count: "34",
                    text: "Active Referrals",
                    width: screenWidth * 0.27,
                  ),

                  SizedBox(width: screenHeight * 0.01),
                  // SizedBox(width: screenHeight * 0.02),
                  ReferralCard(
                    count: "\$120",
                    text: "Reward Earned",
                    width: screenWidth * 0.27,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.001),
              // LineChartSample2(),
              // SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavigationButton(
                    text: "FAQs",
                    onPressed: () {},
                    width: screenWidth * 0.4,
                  ),
                  NavigationButton(
                    text: "Help & Support",
                    onPressed: () {},
                    width: screenWidth * 0.4,
                  ),
                  SizedBox(height: screenHeight * 0.12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
