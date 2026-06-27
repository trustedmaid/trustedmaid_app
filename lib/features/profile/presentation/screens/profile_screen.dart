import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../maid_services/presentation/screens/in_app_webview_screen.dart';
import 'help_support_screen.dart';

/// Screen presenting customer credentials, saved details, and support menu paths.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gradient Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 26),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Text(
                'More',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Menu Section
            Container(
              margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.verified_user_rounded, 'Trust & Verification', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InAppWebViewScreen(
                          title: 'Trust & Verification',
                          url: 'https://www.trustedmaid.in/verification-process',
                        ),
                      ),
                    );
                  }),
                  _buildDivider(),
                  _buildMenuItem(Icons.question_answer_rounded, 'FAQ', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InAppWebViewScreen(
                          title: 'FAQ',
                          url: 'https://www.trustedmaid.in/faq/',
                        ),
                      ),
                    );
                  }),
                  _buildDivider(),
                  _buildMenuItem(Icons.article_rounded, 'Blogs & Articles', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InAppWebViewScreen(
                          title: 'Blogs & Articles',
                          url: 'https://www.trustedmaid.in/blogs',
                        ),
                      ),
                    );
                  }),
                  _buildDivider(),
                  _buildMenuItem(Icons.info_outline_rounded, 'About Us', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InAppWebViewScreen(
                          title: 'About Us',
                          url: 'https://www.trustedmaid.in/about',
                        ),
                      ),
                    );
                  }),
                  _buildDivider(),
                  _buildMenuItem(Icons.support_agent_rounded, 'Help & Support', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HelpSupportScreen(),
                      ),
                    );
                  }),
                  _buildDivider(),
                  _buildMenuItem(Icons.description_rounded, 'Terms & Privacy', () {
                    _showTermsPrivacyBottomSheet(context);
                  }),
                ],
              ),
            ),

            // Version text
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'TrustedMaid v1.0 · Trusted Help, Happy Homes',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isRed = false}) {
    return ListTile(
      leading: Icon(icon, color: isRed ? Colors.red : AppColors.primary, size: 21),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: isRed ? Colors.red : AppColors.darkText,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 19),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 1,
      color: AppColors.line,
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
            builder: (_) => InAppWebViewScreen(
              title: title,
              url: url,
            ),
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
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
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
