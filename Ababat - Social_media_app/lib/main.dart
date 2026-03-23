import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'core/theme/app_theme.dart';

// Entry point of the Flutter application
void main() {
  runApp(const SocialApp());
}

// Root widget of the application
class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the application
      title: 'Flutter Social',

      // Removes the debug banner in the top right corner
      debugShowCheckedModeBanner: false,

      // Applies the global dark theme defined in AppTheme
      theme: AppTheme.darkTheme,

      // First screen displayed when the app starts
      home: const HomeScreen(),
    );
  }
}