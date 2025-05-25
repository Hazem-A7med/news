import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';
import '../utils/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    context.pushReplacementPageRoute(const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ).animate()
              .fadeIn(duration: 600.ms)
              .scale(delay: 200.ms, duration: 400.ms)
              .then()
              .shimmer(duration: 1200.ms, delay: 800.ms),
            const SizedBox(height: 24),
            const Text(
              'News App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ).animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            const Text(
              'Your Daily News Companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ).animate()
              .fadeIn(delay: 600.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }
} 