import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../main_navigation/presentation/screens/main_navigation_screen.dart';

/// Screen indicating successful submittal of the salary calculator enquiry and displaying the estimation card.
class SalaryEstimationResultScreen extends StatelessWidget {
  final String fullName;
  final String phone;
  final String salaryRange;

  const SalaryEstimationResultScreen({
    super.key,
    required this.fullName,
    required this.phone,
    required this.salaryRange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative background glowing elements for premium aesthetic
            Positioned(
              left: -100,
              top: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  color: AppColors.primary.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              right: -120,
              bottom: -50,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  color: AppColors.accent.withOpacity(0.04),
                ),
              ),
            ),

            // Main scrollable content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Success Check Icon (Double ring animation styled)
                    Center(
                      child: Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: AppColors.success.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: AppColors.success.withOpacity(0.16),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 38,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Enquiry Submitted!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Top Description Message
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: AppColors.darkTextSecondary,
                            fontSize: 14,
                            height: 1.45,
                          ),
                          children: [
                            const TextSpan(text: 'Thank you, '),
                            TextSpan(
                              text: fullName,
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: '. We have generated your estimated salary range and sent your criteria to our placement team.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Receipt-Style Card Container
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(color: AppColors.line),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Top Salary Block with gradient
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF0F172A), // Slate Navy
                                  Color(0xFF1E3A8A), // Royal Blue
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'ESTIMATED MONTHLY SALARY',
                                    style: TextStyle(
                                      color: Color(0xFFFBBF24), // Amber/gold
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  salaryRange,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 2. Receipt Details
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                            child: Column(
                              children: [
                                _buildReceiptRow('Customer Name', fullName),
                                _buildReceiptRow('Phone Number', '+91 $phone'),
                                _buildReceiptRow('Matching Speed', '24 - 48 Hours'),
                                _buildReceiptRow('Enquiry Status', '', isStatus: true),
                                
                                const SizedBox(height: 16),
                                // Custom Dashed Separator
                                CustomPaint(
                                  size: const Size(double.infinity, 1),
                                  painter: DashedLinePainter(),
                                ),
                                const SizedBox(height: 16),

                                // Summary Info note
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 2.0),
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: AppColors.primary,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Rates reflect standard wages for background-verified candidates in Mumbai. Excludes government charges/taxes. Food/room required for 24-hr live-in support.',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 10.5,
                                          height: 1.45,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Coordinator follow-up notification card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: AppColors.primary.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          // ignore: deprecated_member_use
                          color: AppColors.primary.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.brandSoft,
                            ),
                            child: const Icon(
                              Icons.phone_in_talk_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Placement Callback',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: AppColors.darkTextSecondary,
                                      fontSize: 12,
                                      height: 1.35,
                                    ),
                                    children: [
                                      TextSpan(text: 'Coordinator will call you back within '),
                                      TextSpan(
                                        text: '2 hours',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: ' with candidate matches.'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Return Home Button (Primary gradient theme with icon and shadow)
                    SizedBox(
                      width: 200,
                      height: 48,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: AppColors.primary.withOpacity(0.24),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MainNavigationScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Back to Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isStatus)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Enquiry Sent',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              value,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = AppColors.line
      ..strokeWidth = 1.5;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
