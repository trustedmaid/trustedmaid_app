import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../maid_services/presentation/screens/maid_services_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

/// Container housing the Bottom Navigation controller structure.
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MaidServicesScreen(),
    // BookingsListScreen(),
    SupportScreen(),
  ];

  final List<CustomBottomNavBarItem> _navItems = const [
    CustomBottomNavBarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    CustomBottomNavBarItem(
      icon: Icons.cleaning_services_outlined,
      activeIcon: Icons.cleaning_services_rounded,
      label: 'Services',
    ),
    // CustomBottomNavBarItem(
    //   icon: Icons.event_note_outlined,
    //   activeIcon: Icons.event_note_rounded,
    //   label: 'Bookings',
    // ),
    CustomBottomNavBarItem(
      icon: Icons.headset_mic_outlined,
      activeIcon: Icons.headset_mic_rounded,
      label: 'Support',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: CustomBottomNavBar(
            currentIndex: _currentIndex,
            items: _navItems,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
