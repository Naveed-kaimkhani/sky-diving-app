import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberField extends StatelessWidget {
    final Function(String) onPhoneChanged;

  const PhoneNumberField({super.key, required this.onPhoneChanged});
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        filled: true,
           fillColor: const Color.fromARGB(255, 26, 25, 25),
        labelText: 'Phone Number',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color:const Color.fromARGB(255, 26, 25, 25),),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: const Color.fromARGB(255, 26, 25, 25),),
        ),
      ),
      initialCountryCode: 'US',
      style: TextStyle(color: Colors.white),
      dropdownIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
      onChanged: (phone) {
        // print(phone.completeNumber);
        log(phone.completeNumber);
                onPhoneChanged(phone.completeNumber); // pass value to controller

      },
    );
  }
}
