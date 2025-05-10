// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sky_diving/components/auth_button.dart';
// import 'package:sky_diving/components/custom_textfield.dart';
// import 'package:sky_diving/components/title_appbar.dart';
// import 'package:sky_diving/view/splash_screen.dart';
// import 'package:sky_diving/view_model/auth_controller.dart';
// import 'package:sky_diving/view_model/user_controller.dart';

// import 'package:http/http.dart' as http;

// class UpdateProfile extends StatefulWidget {
//   UpdateProfile({Key? key}) : super(key: key);

//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }

// class _UpdateProfileState extends State<UpdateProfile> {
//   final UserController userController = Get.find<UserController>();

//   final AuthController authController = Get.put(AuthController());

//   TextEditingController firstName = TextEditingController();

//   TextEditingController lastname = TextEditingController();

//   File? profilePhoto;

//   Future<void> pickImage(bool isProfile) async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         if (isProfile) {
//           profilePhoto = File(pickedFile.path);
//         } else {}
//       });
//     }
//   }

//   Future<void> updateUserProfile() async {
//     if (true) {
//       authController.isLoading.value =
//           true; // Set isLoading to true when the API call starts

//       try {
//         var url =
//             Uri.parse('https://deinfini.com/info/public/api/update-profile');
//         var request = http.MultipartRequest('POST', url);

//         request.headers.addAll({
//           'Authorization': 'Bearer ${userController.token.value}',
//           'Accept': 'application/json',
//         });

//         final user = userController.user.value;

//         // Add required fields
//         request.fields['user_id'] = user?.id.toString() ?? '';
//         request.fields['first_name'] =
//             firstName.text.isEmpty ? (user?.name ?? '') : firstName.text;
//         request.fields['last_name'] =
//             lastname.text.isEmpty ? (user?.lastName ?? '') : lastname.text;

//         // Add avatar image if selected
//         if (profilePhoto != null) {
//           request.files.add(await http.MultipartFile.fromPath(
//               'avatar_url', profilePhoto!.path));
//         }

//         var response = await request.send();
//         log(response.statusCode.toString());
//         if (response.statusCode == 200) {
//           final responseBody = await response.stream.bytesToString();
//           final Map<String, dynamic> responseData = jsonDecode(responseBody);

//           final String userName = responseData["data"]["first_name"];
//           final String lastName = responseData["data"]["last_name"];
//           final String? profileImage = responseData["data"]["avatar_url"];

//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('first_name', userName);
//           await prefs.setString('profile_photo_url', profileImage ?? '');
//           await prefs.setString('last_name', lastName);

//           await userController.getUserFromPrefs();
//           Get.snackbar("Info", "Profile Updated Successfully",
//               colorText: Colors.white);
//           Get.offAll(() => SplashScreen());
//         } else {
//           final responseBody = await response.stream.bytesToString();
//           final errorData = jsonDecode(responseBody);
//           Get.snackbar(
//               "Error", errorData['message'] ?? 'Failed to update profile',
//               colorText: Colors.white);
//         }
//       } catch (e) {
//         Get.snackbar("Exception", e.toString(), colorText: Colors.white);
//       } finally {
//         authController.isLoading.value =
//             false; // Set isLoading to false when the API call completes
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: TitleAppBar(
//         onBackPressed: () => Get.back(),
//         title: "Update Profile",
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.05, // Responsive padding
//           vertical: screenHeight * 0.02,
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.08),

//             // Profile Image
//             Stack(
//               children: [
//                 Center(
//                   child: Container(
//                     width: screenWidth * 0.24, // Responsive width
//                     height: screenWidth * 0.24, // Responsive height
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.green, width: 2),
//                     ),
//                     child: GestureDetector(
//                       onTap: () =>
//                           pickImage(true), // Your existing image picker
//                       child: ClipOval(
//                         child: Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             image: profilePhoto != null
//                                 ? DecorationImage(
//                                     image: FileImage(profilePhoto!),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : (userController.user.value?.proiflePic
//                                             ?.isNotEmpty ??
//                                         false
//                                     ? DecorationImage(
//                                         image: NetworkImage(userController
//                                             .user.value!.proiflePic!),
//                                         fit: BoxFit.cover,
//                                       )
//                                     : null),
//                           ),
//                           child: Icon(
//                             Icons.camera_alt,
//                             size: 50,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: 60,
//                     left: 200,
//                     child: Container(
//                       height: screenWidth * 0.08, // Adaptive size
//                       width: screenWidth * 0.08,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.camera_alt_outlined,
//                         color: Colors.black,
//                         size: screenWidth * 0.06,
//                       ),
//                     ))
//               ],
//             ),

//             SizedBox(height: screenHeight * 0.05),

//             CustomTextField(
//                 controller: firstName,
//                 hintText: userController.user.value!.name),

//             SizedBox(height: screenHeight * 0.02),
//             CustomTextField(
//                 controller: lastname,
//                 hintText: userController.user.value!.lastName),
//             SizedBox(height: screenHeight * 0.02),
//             CustomTextField(
//                 hintText: userController.user.value!.email, obscureText: true),
//             SizedBox(height: screenHeight * 0.02),
//             CustomTextField(
//                 hintText: userController.user.value!.phone, obscureText: true),
//             SizedBox(height: screenHeight * 0.04),
//             AuthButton(
//               buttonText: "Update",
//               onPressed: () {
//                 updateUserProfile();
//               },
//               isLoading: false.obs,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/title_appbar.dart';
import 'package:sky_diving/view/splash_screen.dart';
import 'package:sky_diving/view_model/auth_controller.dart';
import 'package:sky_diving/view_model/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.put(AuthController());

  late TextEditingController firstName;
  late TextEditingController lastname;
  File? profilePhoto;

  @override
  void initState() {
    super.initState();
    final user = userController.user.value;
    firstName = TextEditingController(text: user?.name ?? '');
    lastname = TextEditingController(text: user?.lastName ?? '');
  }

  @override
  void dispose() {
    firstName.dispose();
    lastname.dispose();
    super.dispose();
  }

  bool get hasChanges {
    final user = userController.user.value;
    return firstName.text != user?.name ||
        lastname.text != user?.lastName ||
        profilePhoto != null;
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profilePhoto = File(pickedFile.path);
      });
    }
  }

  Future<void> updateUserProfile() async {
    if (!hasChanges) {
      Get.snackbar("Info", "No changes detected", colorText: Colors.white);
      return;
    }

    authController.isLoading.value = true;

    try {
      var url =
          Uri.parse('https://deinfini.com/info/public/api/update-profile');
      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer ${userController.token.value}',
        'Accept': 'application/json',
      });

      final user = userController.user.value;

      request.fields['user_id'] = user?.id.toString() ?? '';
      request.fields['first_name'] = firstName.text;
      request.fields['last_name'] = lastname.text;

      if (profilePhoto != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'avatar_url', profilePhoto!.path));
      }

      var response = await request.send();
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = jsonDecode(responseBody);

        final String userName = responseData["data"]["first_name"];
        final String lastName = responseData["data"]["last_name"];
        final String? profileImage = responseData["data"]["avatar_url"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('first_name', userName);
        await prefs.setString('profile_photo_url', profileImage ?? '');
        await prefs.setString('last_name', lastName);

        await userController.getUserFromPrefs();
        Get.snackbar("Success", "Profile Updated Successfully",
            colorText: Colors.white);
        Get.offAll(() => SplashScreen());
      } else {
        final responseBody = await response.stream.bytesToString();
        final errorData = jsonDecode(responseBody);
        Get.snackbar(
            "Error", errorData['message'] ?? 'Failed to update profile',
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: ${e.toString()}",
          colorText: Colors.white);
    } finally {
      authController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final user = userController.user.value;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "Update Profile",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.04),

            // Profile Image
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundColor: Colors.grey[300],
                    child: Stack(
                      children: [
                        if (profilePhoto != null)
                          ClipOval(
                            child: Image.file(
                              profilePhoto!,
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.3,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (user?.proiflePic?.isNotEmpty ?? false)
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user!.proiflePic!,
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.3,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Icon(
                                Icons.person,
                                size: screenWidth * 0.15,
                                color: Colors.white,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: screenWidth * 0.15,
                                color: Colors.white,
                              ),
                            ),
                          )
                        else
                          Icon(
                            Icons.person,
                            size: screenWidth * 0.15,
                            color: Colors.white,
                          ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: screenWidth * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.05),

            CustomTextField(
              controller: firstName,
              hintText: user?.name ?? 'First Name',
              onChanged: (_) => setState(() {}),
            ),

            SizedBox(height: screenHeight * 0.02),

            CustomTextField(
              controller: lastname,
              hintText: user?.lastName ?? 'Last Name',
              onChanged: (_) => setState(() {}),
            ),

            SizedBox(height: screenHeight * 0.02),

            CustomTextField(
              hintText: user?.email ?? 'Email',
              obscureText: false,
            ),

            SizedBox(height: screenHeight * 0.02),

            CustomTextField(
              hintText: user?.phone ?? 'Phone',
              obscureText: false,
            ),

            SizedBox(height: screenHeight * 0.04),

            // Obx(() => AuthButton(
            //   buttonText: "Update",
            //   onPressed: hasChanges ? updateUserProfile : null,
            //   isLoading: authController.isLoading,
            // )),
            Obx(() => AuthButton(
                  buttonText: "Update",
                  onPressed: hasChanges ? () => updateUserProfile() : () {},
                  isLoading: authController.isLoading,
                )),
          ],
        ),
      ),
    );
  }
}
