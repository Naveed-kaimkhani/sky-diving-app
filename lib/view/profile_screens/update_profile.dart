import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_diving/components/auth_button.dart';
import 'package:sky_diving/components/custom_textfield.dart';
import 'package:sky_diving/components/title_appbar.dart';
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
    if (firstName.text.length > 30 || lastname.text.length > 30) {
      Get.snackbar("Validation Error",
          "First and Last name must be under 30 characters.",
          colorText: Colors.white);
      return;
    }
    authController.isLoading.value = true;
// https://skydiverentalapp.com/api
    try {
      var url = Uri.parse('https://skydiverentalapp.com/api/update-profile');
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
        request.files.add(
          await http.MultipartFile.fromPath('avatar', profilePhoto!.path),
        );
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(responseBody);

        final String userName = responseData["data"]["first_name"];
        final String lastName = responseData["data"]["last_name"];
        final String? profileImage = responseData["data"]["avatar_url"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('first_name', userName);
        await prefs.setString('avatar_url', profileImage ?? '');
        await prefs.setString('last_name', lastName);

        await userController.getUserFromPrefs();
        Get.back();

        Get.snackbar("Success", "Profile Updated Successfully",
            colorText: Colors.white);
      } else {
        try {
          final errorData = jsonDecode(responseBody);
          final errorMessage =
              errorData['message'] ?? 'Failed to update profile';
          Get.snackbar("Error", errorMessage, colorText: Colors.white);
        } catch (e) {
          Get.snackbar("Error", responseBody, colorText: Colors.white);
        }
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
              readOnly: true,
              hintText: user?.email ?? 'Email',
              obscureText: false,
            ),

            SizedBox(height: screenHeight * 0.02),

            CustomTextField(
              readOnly: true,
              hintText: user?.phone ?? 'Phone',
              obscureText: false,
            ),

            SizedBox(height: screenHeight * 0.04),

            Center(
              child: Obx(() => AuthButton(
                    buttonText: "Update",
                    onPressed: hasChanges ? () => updateUserProfile() : () {},
                    isLoading: authController.isLoading,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
