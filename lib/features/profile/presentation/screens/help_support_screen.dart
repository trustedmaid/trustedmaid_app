import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../resources/app_colors.dart';

/// Screen exhibiting Customer Support contact options (Call, WhatsApp, Email).
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open contact method: $urlString'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Reach out to our customer happiness team through any of these channels below:',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // Horizontal Contact Cards Row
            SizedBox(
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildContactCard(
                    context,
                    icon: Icons.phone_rounded,
                    iconBgColor: const Color(0xFF2563EB), // Solid blue
                    label: 'CALL US',
                    value: '+91 7718003880',
                    onTap: () => _launchUrl(context, 'tel:+917718003880'),
                  ),
                  const SizedBox(width: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.chat_bubble_rounded,
                    iconBgColor: const Color(0xFF22C55E), // Solid WhatsApp green
                    label: 'WHATSAPP',
                    value: 'Chat Instantly',
                    onTap: () => _launchUrl(context, 'https://wa.me/917718003880'),
                  ),
                  const SizedBox(width: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.email_rounded,
                    iconBgColor: const Color(0xFFEA580C), // Solid orange-red
                    label: 'EMAIL US',
                    value: 'contact@trustedmaid.in',
                    onTap: () => _launchUrl(context, 'mailto:contact@trustedmaid.in'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Helpful FAQ details
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 12),
            _buildFAQTile(
              'How long does it take to find a maid?',
              'Once you submit an enquiry, our coordinator will match and place a background-verified helper in your locality within 24 to 48 hours.',
            ),
            _buildFAQTile(
              'Is there any replacement guarantee?',
              'Yes! We provide free replacement support. We offer up to 3 replacements for a 1-year contract and 1 replacement for a 3-to-6-month contract.',
            ),
            _buildFAQTile(
              'Do I have to pay anything up front?',
              'No! You only pay after you meet and approve the helper candidate.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.line),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            answer,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
