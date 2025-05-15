import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_diving/components/title_appbar.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<bool> _isExpanded = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleAppBar(
        onBackPressed: () => Get.back(),
        title: "FAQs",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: List.generate(_faqItems.length, (index) {
              return _buildFAQItem(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded[index] = !_isExpanded[index];
            });
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _faqItems[index]['question'] ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded[index] ? Icons.expand_less : Icons.expand_more,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded[index])
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _faqItems[index]['answer'] ?? "",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        SizedBox(height: 8),
      ],
    );
  }
}

List<Map<String, String>> _faqItems = [
  {
    'question': '1. How do I refer a friend?',
    'answer':
        'You can refer a friend by sharing your unique QR code or referral link. Go to the Referral section in the app, tap on the QR code, and share it via WhatsApp, SMS, or email. Alternatively, copy your referral link and share it directly with your friends. When they sign up using your link or code, you’ll earn rewards!'
  },
  {
    'question': '2. How do I redeem rewards?',
    'answer':
        'You can redeem rewards by navigating to the rewards section in the app and following the instructions.'
  },
  {
    'question': '3. Can I refer more than one friend?',
    'answer':
        'Yes, you can refer multiple friends, and each successful referral will earn you rewards!'
  },
  {
    'question': '4. What types of rewards can I earn?',
    'answer':
        'Rewards may include discounts, coupons, or other benefits based on the referral program.'
  },
  {
    'question':
        '5. What happens if my friend doesn’t complete the signup process?',
    'answer':
        'If your friend does not complete the signup, you will not receive rewards until they do.'
  }
];
