import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/app_fonts.dart';
import '../../../main_navigation/presentation/screens/main_navigation_screen.dart';

/// Introductory Onboarding walkthrough screen with interactive PageView.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = const [
    {
      'image': 'assets/services/house_maid.webp',
      'title': 'Verified House Maids',
      'desc': 'Daily sweeping, mopping, utensil cleaning, laundry & home organization. Background-verified professionals for your peace of mind.',
    },
    {
      'image': 'assets/services/cook.webp',
      'title': 'Experienced Home Cooks',
      'desc': 'Hygienic, delicious meals prepared to your custom taste. Vetted professionals for daily cooking or special occasions.',
    },
    {
      'image': 'assets/services/baby_sitter.webp',
      'title': 'Nurturing Care & Support',
      'desc': 'Safe child care, baby sitting, post-delivery Japa support, and compassionate elderly care routines for your loved ones.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainNavigationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            // PageView content (curved illustration and descriptions)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Column(
                    children: [
                      // Header curved banner with illustrative service image
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Soft glow effects
                            Positioned(
                              left: -30,
                              top: -30,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.06),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -40,
                              bottom: 20,
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.04),
                                ),
                              ),
                            ),
                            // Service Image inside Card Container
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: MediaQuery.of(context).size.height * 0.28,
                              margin: const EdgeInsets.only(top: 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Image.asset(
                                  page['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Text Description Panel
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              page['title']!,
                              style: const TextStyle(
                                fontSize: 24,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.primaryFont,
                                letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              page['desc']!,
                              style: const TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 14,
                                height: 1.55,
                                fontFamily: AppFonts.primaryFont,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Page Indicators & Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Indicators (animated dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final isSelected = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isSelected ? 22 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : const Color(0xFFD1D5DB),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  // CTA Action Buttons
                  Row(
                    children: [
                      // Skip option (hidden on last page)
                      if (_currentPage < _pages.length - 1)
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.brandSoft, width: 1.5),
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: _navigateToMain,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                          ),
                        ),
                      if (_currentPage < _pages.length - 1) const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            elevation: 2,
                          ),
                          onPressed: () {
                            if (_currentPage < _pages.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _navigateToMain;
                              _navigateToMain();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentPage == _pages.length - 1 ? 'Get Started' : 'Continue',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
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
    );
  }
}
