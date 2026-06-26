import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../maid_services/presentation/screens/maid_services_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

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
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services_outlined),
            activeIcon: Icon(Icons.cleaning_services_rounded),
            label: 'Services',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.event_note_outlined),
          //   activeIcon: Icon(Icons.event_note_rounded),
          //   label: 'Bookings',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
