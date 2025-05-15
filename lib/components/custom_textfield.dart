

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;  // Make readOnly nullable

  const CustomTextField({
    Key? key,
    this.iconData,
    required this.hintText,
    this.controller,
    this.keyboardType,
        this.readOnly,  // The readOnly parameter is now nullable

    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,

      style: const TextStyle(color: Colors.white), // 👈 This sets the entered text color
      onChanged: onChanged,
      cursorColor: Colors.white,
readOnly: readOnly ?? false,
      //  style: const TextStyle(color: Colors.white), 
      decoration: InputDecoration(
        suffixIcon:  Icon(iconData),
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