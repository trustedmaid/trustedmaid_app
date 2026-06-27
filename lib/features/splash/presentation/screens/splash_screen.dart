import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trustedmaid/features/main_navigation/presentation/screens/main_navigation_screen.dart';

import '../../../../resources/app_assets.dart';

/// Entry splash screen displaying a fullscreen cover image with automated transition.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Automatically transition to Main Screen after 2.5 seconds
    _timer = Timer(const Duration(milliseconds: 2500), _navigateToMain);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigateToMain() {
    if (_navigated) return;
    setState(() {
      _navigated = true;
    });
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splashScreenImg,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
