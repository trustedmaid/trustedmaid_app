import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/extensions.dart';
import '../../../main_navigation/presentation/screens/main_navigation_screen.dart';

/// Screen presenting real-time status of placement matching processes.
class LiveTrackingScreen extends StatelessWidget {
  final String serviceName;
  final String planName;

  const LiveTrackingScreen({
    super.key,
    required this.serviceName,
    required this.planName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
            );
          },
        ),
        title: const Text('Booking #TM-48217'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Service Summary Card
            Container(
              margin: const EdgeInsets.fromLTRB(18, 6, 18, 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.line),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: AppColors.brandSoft,
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                    child: Icon(Icons.cleaning_services_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$serviceName · $planName',
                        style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Requested today, 9:24 AM',
                        style: TextStyle(color: Colors.grey, fontSize: 11.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stepper timeline tracker
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  _buildTrackStep(
                    title: 'Request received',
                    sub: "We've got your requirement",
                    isDone: true,
                    isNow: false,
                    icon: Icons.check_rounded,
                  ),
                  _buildTrackStep(
                    title: 'Team called you',
                    sub: 'Requirements confirmed',
                    isDone: true,
                    isNow: false,
                    icon: Icons.check_rounded,
                  ),
                  _buildTrackStep(
                    title: 'Matching verified pro',
                    sub: 'Shortlisting 3 candidates near Powai',
                    isDone: false,
                    isNow: true,
                    icon: Icons.search_rounded,
                  ),
                  _buildTrackStep(
                    title: 'Meet & approve',
                    sub: 'You meet the pro before confirming',
                    isDone: false,
                    isNow: false,
                    icon: Icons.groups_rounded,
                  ),
                  _buildTrackStep(
                    title: 'Service starts',
                    sub: 'Begin with full confidence',
                    isDone: false,
                    isNow: false,
                    icon: Icons.home_rounded,
                    isLast: true,
                  ),
                ],
              ),
            ),

            // Call / chat options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.call_rounded),
                      label: const Text('Call our team', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.brandSoft),
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        context.showSnackBar('Calling team at +91 7718003880');
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.chat_rounded),
                      label: const Text('WhatsApp us', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        context.showSnackBar('Opening WhatsApp support thread');
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackStep({
    required String title,
    required String sub,
    required bool isDone,
    required bool isNow,
    required IconData icon,
    bool isLast = false,
  }) {
    Color circleColor = AppColors.line;
    Color iconColor = Colors.white;
 
    if (isDone) {
      circleColor = AppColors.success;
      iconColor = Colors.white;
    } else if (isNow) {
      circleColor = AppColors.primary;
      iconColor = Colors.white;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot and lines
          Column(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                  boxShadow: isNow
                      ? [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: AppColors.primary.withOpacity(0.2),
                            spreadRadius: 4,
                          )
                        ]
                      : null,
                ),
                child: Center(
                  child: Icon(icon, color: iconColor, size: 15),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDone ? AppColors.success : AppColors.line,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 13),
          
          // Texts
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.secondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
