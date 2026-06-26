import 'package:flutter/material.dart';
import 'core/di/injection_container.dart' as di;
import 'config/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() async {
  // Ensure widget binding is initialized before running dependency injection
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trusted Maid - Domestic Help Services',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Dynamically adapts to device brightness settings
      home: const SplashScreen(),
    );
  }
}
