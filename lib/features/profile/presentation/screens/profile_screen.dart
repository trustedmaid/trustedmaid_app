import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../maid_services/presentation/screens/in_app_webview_screen.dart';
import 'help_support_screen.dart';
import 'agent_registration_screen.dart';
import 'maid_registration_screen.dart';

/// Screen presenting support menu paths, FAQs, blogs, verification, and legal details.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ), // Modern slate white/gray background
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with rich styling and circular background visual elements
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 70, 24, 45),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary, // Classic Blue
                        AppColors.secondary, // Deep Navy
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.headset_mic_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Support Center',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "We're here to help you build a happier home.",
                        style: TextStyle(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Visual decorative blob
                Positioned(
                  right: -40,
                  top: -40,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.03),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Grid Section Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'How can we help you?',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Grid layout using official app branding colors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.05,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _buildGridCard(
                    context: context,
                    icon: Icons.support_agent_rounded,
                    iconColor: AppColors.accent, // Brand Orange
                    title: 'Contact Support',
                    subtitle: 'Chat or talk to our live support team',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),
                  _buildGridCard(
                    context: context,
                    icon: Icons.help_outline_rounded,
                    iconColor: AppColors.primary, // Brand Blue
                    title: 'FAQs',
                    subtitle: 'Frequently asked questions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InAppWebViewScreen(
                            title: 'FAQ',
                            url: 'https://www.trustedmaid.in/faq/',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildGridCard(
                    context: context,
                    icon: Icons.verified_user_rounded,
                    iconColor: AppColors.success, // Success Green
                    title: 'Verification',
                    subtitle: 'Learn about our helper safety check',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InAppWebViewScreen(
                            title: 'Trust & Verification',
                            url:
                                'https://www.trustedmaid.in/verification-process',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildGridCard(
                    context: context,
                    icon: Icons.menu_book_rounded,
                    iconColor: AppColors.brand2, // Lighter Brand Blue
                    title: 'Blogs & Articles',
                    subtitle: 'Read domestic guides, news & tips',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InAppWebViewScreen(
                            title: 'Blogs & Articles',
                            url: 'https://www.trustedmaid.in/blogs',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Join Our Network Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Join Our Network',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildListTile(
                    icon: Icons.people_outline_rounded,
                    title: 'Register as an Agent',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AgentRegistrationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildListTile(
                    icon: Icons.assignment_ind_outlined,
                    title: 'Register as a Maid',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MaidRegistrationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Secondary Options Section Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Company & Legal',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Secondary Options list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildListTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About Trusted Maid',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InAppWebViewScreen(
                            title: 'About Us',
                            url: 'https://www.trustedmaid.in/about',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildListTile(
                    icon: Icons.description_outlined,
                    title: 'Terms & Privacy Policy',
                    onTap: () {
                      _showTermsPrivacyBottomSheet(context);
                    },
                  ),
                ],
              ),
            ),

            // Footer version text
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 36.0),
                child: Text(
                  'TrustedMaid v1.0.0 · Trusted Help, Happy Homes',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFF1F5F9), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFF1F5F9), width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary, // Brand blue color
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF94A3B8),
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showTermsPrivacyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Terms & Privacy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Please select the document you wish to view',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.darkTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildBottomSheetOption(
                context: context,
                icon: Icons.description_rounded,
                title: 'Terms of Use',
                subtitle: 'Review our agreement guidelines',
                url: 'https://www.trustedmaid.in/term/',
              ),
              const SizedBox(height: 12),
              _buildBottomSheetOption(
                context: context,
                icon: Icons.privacy_tip_rounded,
                title: 'Privacy Policy',
                subtitle: 'Understand how we protect your data',
                url: 'https://www.trustedmaid.in/privacy-policy/',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InAppWebViewScreen(title: title, url: url),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: AppColors.brandSoft.withOpacity(0.4),
          border: Border.all(color: AppColors.brandSoft),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.darkTextSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
