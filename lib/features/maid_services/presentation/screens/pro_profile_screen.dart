import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../booking/presentation/screens/booking_flow_screen.dart';

/// Screen presenting the background and qualifications of a specific helper (e.g. Sunita Kamble).
class ProProfileScreen extends StatelessWidget {
  const ProProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blue Gradient Profile Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 50, 16, 28),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.secondary, AppColors.primary],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Center(
                            child: Text(
                              'SK',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sunita Kamble',
                              style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.verified_rounded, color: Color(0xFF9DFFCE), size: 18),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'House Maid · 6 years experience · Powai',
                          // ignore: deprecated_member_use
                          style: TextStyle(color: Colors.white.withOpacity(0.86), fontSize: 12.5),
                        ),
                      ],
                    ),
                  ),

                  // Stats Row
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Row(
                      children: [
                        _buildStatItem('4.9', 'Rating'),
                        _buildDivider(),
                        _buildStatItem('120', 'Homes served'),
                        _buildDivider(),
                        _buildStatItem('98%', 'Rehired'),
                      ],
                    ),
                  ),

                  // Verification Group
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Text(
                      'Verification',
                      style: TextStyle(color: AppColors.secondary, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    crossAxisCount: 2,
                    childAspectRatio: 3.2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    children: [
                      _buildVerifChip(Icons.badge_rounded, 'Aadhaar verified'),
                      _buildVerifChip(Icons.local_police_rounded, 'Police checked'),
                      _buildVerifChip(Icons.contact_phone_rounded, 'References'),
                      _buildVerifChip(Icons.health_and_safety_rounded, 'Health screened'),
                    ],
                  ),

                  // Skills chips
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    child: Text(
                      'Skills',
                      style: TextStyle(color: AppColors.secondary, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        _SkillChip(title: 'Deep cleaning'),
                        _SkillChip(title: 'Laundry'),
                        _SkillChip(title: 'Ironing'),
                        _SkillChip(title: 'Kitchen Chores'),
                      ],
                    ),
                  ),

                  // Client reviews
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    child: Text(
                      'Reviews',
                      style: TextStyle(color: AppColors.secondary, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildReviewCard('Priya N.', 'She knows our routine better than we do. Punctual, thorough and trustworthy — with us 8 months now.', 5.0, 'P'),
                  _buildReviewCard('Rohit S.', 'Very professional and detail-oriented. The home has never been cleaner. Highly recommend.', 4.8, 'R'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom sticky purchase controls
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.brandSoft, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(Icons.chat_rounded, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookingFlowScreen(
                              serviceName: 'House Maid',
                              planName: 'Full-time',
                              monthlyCharge: 12000,
                            ),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Request Sunita', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String bold, String small) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        child: Column(
          children: [
            Text(
              bold,
              style: const TextStyle(color: AppColors.secondary, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              small,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 30,
      color: AppColors.line,
    );
  }

  Widget _buildVerifChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.successSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.success, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.success, fontSize: 11.5, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String author, String reviewText, double stars, String initial) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: AppColors.brandSoft,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Text(
                author,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber[700], size: 15),
                  const SizedBox(width: 2),
                  Text(
                    stars.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '"$reviewText"',
            style: const TextStyle(color: Colors.grey, fontSize: 11.5, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String title;

  const _SkillChip({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}
