import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ContactUtils {
  static Future<void> launchEmail({
    required BuildContext context,
    String email = 'skydivingrental@gmail.com',
    String? subject,
    String? body,
    
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        _showLaunchError(context, 'email');
      }
    } catch (e) {
      _showLaunchError(context, 'email');
    }
  }

  static Future<void> launchPhone({
    required BuildContext context,
    String phoneNumber = '720-352-2151',
  }) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(phoneLaunchUri)) {
        await launchUrl(phoneLaunchUri);
      } else {
        _showLaunchError(context, 'phone');
      }
    } catch (e) {
      _showLaunchError(context, 'phone');
    }
  }

  static Future<void> launchWebsite({
    required BuildContext context,
    String website = 'https://sgras.com',
  }) async {
    // Ensure website has https:// prefix
    final String formattedWebsite = 
        website.startsWith('http') ? website : 'https://$website';
    
    try {
      if (await canLaunchUrl(Uri.parse(formattedWebsite))) {
        await launchUrl(
          Uri.parse(formattedWebsite),
          mode: LaunchMode.externalApplication,
        );
      } else {
        _showLaunchError(context, 'website');
      }
    } catch (e) {
      _showLaunchError(context, 'website');
    }
  }

  static void _showLaunchError(BuildContext context, String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not launch $type'),
        backgroundColor: Colors.red,
      ),
    );
  }
}