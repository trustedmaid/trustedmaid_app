import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/theme/app_theme.dart';
import 'core/di/injection_container.dart' as di;
import 'features/splash/presentation/screens/splash_screen.dart';

void main() async {
  // Ensure widget binding is initialized before running dependency injection
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  // Force portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          ThemeMode.system, // Dynamically adapts to device brightness settings
      home: const SplashScreen(),
    );
  }
}
