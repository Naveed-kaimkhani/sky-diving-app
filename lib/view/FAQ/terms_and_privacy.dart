import 'package:flutter/material.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  const TermsAndPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Terms & Privacy Policy",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("1. Acceptance of Terms",
                "By accessing or using the App, you confirm that you have read, understood, and agree to be bound by these Terms and Conditions. If you do not agree, you must not use the App."),
            _buildSection("2. Eligibility",
                "You must be at least 18 years old to use the App. By using the App, you represent and warrant that you meet this age requirement."),
            _buildSection("3. User Account", """
• You are responsible for maintaining the confidentiality of your account credentials (email and password).
• You agree to notify us immediately of any unauthorized use of your account.
• We reserve the right to suspend or terminate your account if we suspect any fraudulent or unauthorized activity.
"""),
            _buildSection("4. Referral Program", """
• The App allows you to refer friends and earn rewards.
• Referrals must be genuine, and any attempt to manipulate the system (e.g., fake accounts, spam) will result in the forfeiture of rewards and potential account suspension.
• Rewards are subject to change and may vary based on promotional offers.
"""),
            _buildSection("5. Rewards and Redemption", """
• Rewards earned through the App are non-transferable and cannot be exchanged for cash.
• We reserve the right to modify, cancel, or revoke rewards at any time without prior notice.
• Rewards may have expiration dates, and it is your responsibility to redeem them before they expire.
"""),
            _buildSection("6. Privacy Policy",
                "Your use of the App is also governed by our Privacy Policy, which outlines how we collect, use, and protect your personal information. By using the App, you consent to the practices described in the Privacy Policy."),
            _buildSection("7. Prohibited Activities", """
• You agree not to:
  - Use the App for any illegal or unauthorized purposes.
  - Harass, abuse, or harm other users.
  - Attempt to gain unauthorized access to the App or its systems.
  - Use automated tools (e.g., bots, scripts) to interact with the App.
"""),
            _buildSection("8. Intellectual Property", """
• All content, logos, and designs in the App are the property of Skydive Pro and are protected by intellectual property laws.
• You may not copy, reproduce, or distribute any content from the App without prior written permission.
"""),
            _buildSection("9. Limitation of Liability", """
• The App is provided "as is" without any warranties, express or implied.
• We are not liable for any damages arising from your use of the App, including but not limited to loss of data, profits, or business opportunities.
"""),
            _buildSection("10. Changes to Terms",
                "We reserve the right to update or modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting in the App. Your continued use of the App constitutes acceptance of the updated terms."),
            _buildSection("11. Governing Law",
                "These Terms and Conditions are governed by the laws of [Your Country/State]. Any disputes arising from your use of the App will be resolved in the courts of [Your Country/State]."),
            _buildSection("12. Contact Us", """
If you have any questions or concerns about these Terms and Conditions, please contact us at:
Email: support@skydivpro.com
Phone: 720-352-2151
"""),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              content,
              style:
                  TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
