// import 'package:flutter/material.dart';
// import 'package:sky_diving/components/profile_item.dart';
// import 'package:sky_diving/constants/app_images.dart';
// import 'package:sky_diving/constants/app_svg_icons.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 60),

//             // Profile Image
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 90,
//                     height: 90,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.green, width: 2),
//                     ),
//                     child: ClipOval(
//                       child: Image.asset(
//                         AppSvgIcons.profile, // Replace with actual image
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     "Welcome",
//                     style: TextStyle(
//                       color: Colors.white54,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const Text(
//                     "Jaydon Bator",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Menu Items
//             ProfileMenuItem(title: "Edit Profile", onTap: () {}),
//             ProfileMenuItem(title: "Change Password", onTap: () {}),
//             ProfileMenuItem(title: "FAQs", onTap: () {}),
//             ProfileMenuItem(title: "Terms & Privacy Policy", onTap: () {}),
//             ProfileMenuItem(title: "Help & Support", onTap: () {}),
//             ProfileMenuItem(title: "Logout", onTap: () {}),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sky_diving/components/profile_item.dart';
import 'package:sky_diving/constants/app_images.dart';
import 'package:sky_diving/constants/app_svg_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive padding
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.08),

            // Profile Image
            Center(
              child: Column(
                children: [
                  Container(
                    width: screenWidth * 0.24, // Responsive width
                    height: screenWidth * 0.24, // Responsive height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppSvgIcons.profile, // Replace with actual image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: screenWidth * 0.035, // Responsive font size
                    ),
                  ),
                  Text(
                    "Jaydon Bator",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Menu Items
            ProfileMenuItem(title: "Edit Profile", onTap: () {}),
            ProfileMenuItem(title: "Change Password", onTap: () {}),
            ProfileMenuItem(title: "FAQs", onTap: () {}),
            ProfileMenuItem(title: "Terms & Privacy Policy", onTap: () {}),
            ProfileMenuItem(title: "Help & Support", onTap: () {}),
            ProfileMenuItem(title: "Logout", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
