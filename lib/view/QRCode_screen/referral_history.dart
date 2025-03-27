// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:sky_diving/components/auth_button.dart';
// import 'package:sky_diving/components/custom_button.dart';
// import 'package:sky_diving/components/custom_toggle_tabs.dart';
// import 'package:sky_diving/components/label_text.dart';
// import 'package:sky_diving/components/line_chart.dart';
// import 'package:sky_diving/components/navigation_button.dart';
// import 'package:sky_diving/components/referral_card.dart';
// import 'package:sky_diving/components/referral_item.dart';
// import 'package:sky_diving/components/reward_balance_card.dart';
// import 'package:sky_diving/constants/app_colors.dart';
// import 'package:sky_diving/constants/app_images.dart';
// import 'package:sky_diving/constants/app_svg_icons.dart';
// import 'package:sky_diving/components/custom_AppBar.dart';
// import 'package:sky_diving/testt.dart';

// class ReferralHistory extends StatelessWidget {
//   const ReferralHistory({super.key});

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
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
           
//               SizedBox(height: screenHeight * 0.02),
//                   LabelText(text: "Referral History", fontSize: 18,),
                  
//               SizedBox(height: 12),
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  SizedBox(
//                   width: 370,
//                   height: 70,
//                   child: CustomTabBar()),
               
//                       // LabelText(text: "Scan QR", fontSize: 12,textColor: AppColors.primaryColor,),
//                ],
//              ),
//               // SizedBox(height: screenHeight * 0.035),
//               // AuthButton(buttonText: "Share QR Code", onPressed: (){}, isLoading: false.obs)
                
//               // SizedBox(height: 12),
//        TransactionCard(
//               amount: "\$10",
//               name: "Jane Doe",
//               date: "12 Jan 2025",
//                 statusImagePath: AppImages.done,
//                 calendarImagePath: AppImages.timer,
//                             amountColor: AppColors.primaryColor,
//               iconColor: Colors.green,

//             ),
//             TransactionCard(
//               amount: "\$20",
//               name: "John Smith",
//               date: "12 Jan 2025",
//                 statusImagePath: AppImages.timer,
//                 calendarImagePath: AppImages.timer, 
//               amountColor: Colors.yellow,
//               iconColor: Colors.yellow,
//             ),
//                 ],
//               ),
            
//           ),
//         ),
//       );
    
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_button.dart';
import 'package:sky_diving/components/custom_toggle_tabs.dart';
import 'package:sky_diving/components/label_text.dart';
import 'package:sky_diving/components/line_chart.dart';
import 'package:sky_diving/components/navigation_button.dart';
import 'package:sky_diving/components/referral_card.dart';
import 'package:sky_diving/components/referral_item.dart';
import 'package:sky_diving/components/reward_balance_card.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';
import 'package:sky_diving/components/custom_AppBar.dart';
import 'package:sky_diving/constants/routes_name.dart';
import 'package:sky_diving/testt.dart';

class ReferralHistory extends StatelessWidget {
  const ReferralHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        username: "Jaydon Bator",
        profileImage: AppSvgIcons.profile,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive horizontal padding
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              LabelText(
                text: "Referral History",
                fontSize: screenWidth * 0.045, // Responsive font size
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.9, // Responsive width
                    height: screenHeight * 0.08, // Responsive height
                    child: CustomTabBar(),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),

              // Transaction List (Responsive)
            GestureDetector(
              onTap: ()=>Get.toNamed(RouteName.rewardScreen),
              child:   TransactionCard(
                amount: "\$10",
                name: "Jane Doe",
                date: "12 Jan 2025",
                statusImagePath: AppImages.done,
                calendarImagePath: AppImages.timer,
                amountColor: AppColors.primaryColor,
                iconColor: Colors.green,
              ),
            ),
              SizedBox(height: screenHeight * 0.015),
              TransactionCard(
                amount: "\$20",
                name: "John Smith",
                date: "12 Jan 2025",
                statusImagePath: AppImages.timer,
                calendarImagePath: AppImages.timer,
                amountColor: Colors.yellow,
                iconColor: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
