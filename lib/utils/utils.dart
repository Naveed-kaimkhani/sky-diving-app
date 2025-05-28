import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class Utils {
 static Future<bool> checkInternetConnection() async {
  final connectivityResults = await Connectivity().checkConnectivity();

  if (connectivityResults.contains(ConnectivityResult.none)) {
    Get.snackbar(
      "No Internet",
      "Please check your connection and try again.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  return true;
}
static String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

 static Future<void> launchWebUrl(context) async {
    final url = Uri.parse('https://www.sgras.com/product/skydiving-gear-rental/3');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Opens in default browser
    )) {
      // setState(() {
      //   _isLoading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

}