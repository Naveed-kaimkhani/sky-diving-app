

// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final IconData? iconData;
//   final ValueChanged<String>? onChanged;
//   final bool? readOnly;  // Make readOnly nullable
//   final bool showToggleVisibilityIcon; // 👈 optional toggle visibility icon

//   const CustomTextField({
//     Key? key,
//     this.iconData,
//     required this.hintText,
//     this.controller,
//         this.showToggleVisibilityIcon = false, // 👈 default is false

//     this.keyboardType,
//         this.readOnly,  // The readOnly parameter is now nullable

//     this.obscureText = false,
//     this.onChanged,
//   }) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,

//       style: const TextStyle(color: Colors.white), // 👈 This sets the entered text color
//       onChanged: onChanged,
//       cursorColor: Colors.white,
// readOnly: readOnly ?? false,
//       //  style: const TextStyle(color: Colors.white), 
//       decoration: InputDecoration(
//         suffixIcon:  Icon(iconData),
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//         filled: true,
//         fillColor: const Color.fromARGB(255, 26, 25, 25),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: Color(0xffCCCCCC), width: 2),
         
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;
  final bool showToggleVisibilityIcon;
  final RxBool? isObscureRx; // 👈 Add RxBool

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.readOnly,
    this.iconData,
    this.obscureText = false,
    this.onChanged,
    this.showToggleVisibilityIcon = false,
    this.isObscureRx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showToggleVisibilityIcon && isObscureRx != null) {
      return Obx(() => _buildTextField(isObscureRx!.value));
    } else {
      return _buildTextField(obscureText);
    }
  }

  Widget _buildTextField(bool isObscure) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      cursorColor: Colors.white,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        suffixIcon: showToggleVisibilityIcon && isObscureRx != null
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  isObscureRx!.value = !isObscureRx!.value;
                },
              )
            : (iconData != null ? Icon(iconData) : null),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color.fromARGB(255, 26, 25, 25),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xffCCCCCC), width: 2),
        ),
      ),
    );
  }
}
