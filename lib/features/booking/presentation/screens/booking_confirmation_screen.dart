import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../main_navigation/presentation/screens/main_navigation_screen.dart';
import 'live_tracking_screen.dart';

/// Screen indicating successful submittal of the booking request.
class BookingConfirmationScreen extends StatelessWidget {
  final String serviceName;
  final String planName;

  const BookingConfirmationScreen({
    super.key,
    required this.serviceName,
    required this.planName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Green Check
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.successSoft,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check_rounded, color: AppColors.success, size: 58),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Request Confirmed!',
                style: TextStyle(fontSize: 22, color: AppColors.secondary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Our team will call you within a few hours to finalize your verified $serviceName placement.',
                style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              
              // Receipt card summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.line),
                ),
                child: Column(
                  children: [
                    _buildSumRow('Booking ID', '#TM-48217'),
                    _buildSumRow('Service', '$serviceName · $planName'),
                    _buildSumRow('Status', 'Matching pro', isBadge: true),
                  ],
                ),
              ),
              const Spacer(),

              // Tracking / Navigation actions
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LiveTrackingScreen(
                          serviceName: serviceName,
                          planName: planName,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Track Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.brandSoft),
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainNavigationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSumRow(String left, String right, {bool isBadge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          if (isBadge)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.brandSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                right,
                style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            )
          else
            Text(
              right,
              style: const TextStyle(color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
