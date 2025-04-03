// import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:sky_diving/constants/app_colors.dart';

// class FilePickerWidget extends StatelessWidget {
//   const FilePickerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DottedBorder(
//       borderType: BorderType.RRect,
//       radius: const Radius.circular(12),
//       dashPattern: const [6, 3],
//       color: AppColors.primaryColor,
//       strokeWidth: 2,
//       child: Container(
//         height: 50,
//         width:double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.upload_file_rounded,
//               color: AppColors.primaryColor,
//               size: 24,
//             ),
//             SizedBox(width: 10),
//             Text(
//               "Choose File",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sky_diving/constants/app_colors.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final size = MediaQuery.of(context).size;
    
    // Calculate responsive dimensions
    final containerHeight = size.height * 0.055; // 6% of screen height
    final borderRadius = size.width * 0.03; // 3% of screen width
    final iconSize = size.width * 0.06; // 6% of screen width
    final fontSize = size.width * 0.04; // 4% of screen width
    final spacing = size.width * 0.02; // 2% of screen width

    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(borderRadius),
      dashPattern: const [6, 3],
      color: AppColors.primaryColor,
      strokeWidth: 2,
      child: Container(
        height: containerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file_rounded,
              color: AppColors.primaryColor,
              size: iconSize,
            ),
            SizedBox(width: spacing),
            Text(
              "Choose File",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}