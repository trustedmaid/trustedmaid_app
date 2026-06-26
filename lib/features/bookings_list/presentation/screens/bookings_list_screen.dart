import 'package:flutter/material.dart';
import '../../../../resources/app_colors.dart';
import '../../../booking/presentation/screens/live_tracking_screen.dart';
import '../../../maid_services/presentation/screens/pro_profile_screen.dart';

/// Screen presenting the user's booking history and active contract statuses.
class BookingsListScreen extends StatefulWidget {
  const BookingsListScreen({super.key});

  @override
  State<BookingsListScreen> createState() => _BookingsListScreenState();
}

class _BookingsListScreenState extends State<BookingsListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Tab
          _buildActiveList(),
          
          // Past Tab
          const Center(
            child: Text(
              'No past bookings found.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveList() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Card 1
        _buildBookingCard(
          title: 'House Maid · Full-time',
          subtitle: 'Sunita K. · Starts tomorrow',
          status: 'MATCHING',
          isUpcoming: true,
          icon: Icons.cleaning_services_rounded,
          onLeftTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LiveTrackingScreen(
                  serviceName: 'House Maid',
                  planName: 'Full-time',
                ),
              ),
            );
          },
          leftLabel: 'Track',
          rightLabel: 'Call team',
        ),
        
        // Card 2
        _buildBookingCard(
          title: 'Cook · Part-time',
          subtitle: 'Lakshmi R. · Mon–Sat, 6 PM',
          status: 'ACTIVE',
          isUpcoming: false,
          icon: Icons.restaurant_rounded,
          onLeftTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProProfileScreen(),
              ),
            );
          },
          leftLabel: 'View pro',
          rightLabel: 'Replace',
        ),
        
        // Card 3
        _buildBookingCard(
          title: 'Elderly Care · Live-in',
          subtitle: 'Asha M. · Day 42',
          status: 'ACTIVE',
          isUpcoming: false,
          icon: Icons.elderly_rounded,
          onLeftTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProProfileScreen(),
              ),
            );
          },
          leftLabel: 'View pro',
          rightLabel: 'Support',
        ),
      ],
    );
  }

  Widget _buildBookingCard({
    required String title,
    required String subtitle,
    required String status,
    required bool isUpcoming,
    required IconData icon,
    required VoidCallback onLeftTap,
    required String leftLabel,
    required String rightLabel,
  }) {
    // ignore: deprecated_member_use
    Color badgeBg = isUpcoming ? AppColors.warning.withOpacity(0.12) : AppColors.successSoft;
    Color badgeText = isUpcoming ? AppColors.warning : AppColors.success;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          // Top body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.brandSoft,
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 25),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.secondary),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: badgeText, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom actions
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.line)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onLeftTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: Text(
                        leftLabel,
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.line,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Support request sent for $title')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: Text(
                        rightLabel,
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
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
}
