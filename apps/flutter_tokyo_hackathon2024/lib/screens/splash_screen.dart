import 'package:flutter/material.dart';
import 'package:helper/presentation/app/navigator_handler.dart';
import 'package:lottie/lottie.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  Future<void> _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // helper 패키지의 네비게이터 핸들러 사용
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/cat_animation_splash.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'ゲーム ローディング中...',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
