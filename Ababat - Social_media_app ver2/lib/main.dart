import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'ui/screens/home_screen.dart'; // Or wherever your main layout is

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      // IF NOT LOGGED IN -> Show LoginScreen
      // IF LOGGED IN -> Show HomeScreen
      home: auth.isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}