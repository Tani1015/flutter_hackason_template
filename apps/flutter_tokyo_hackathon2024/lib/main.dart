import 'package:flutter/material.dart';
import 'package:helper/presentation/app/navigator_handler.dart';
import 'package:helper/presentation/app_wrapper.dart';
import 'package:helper/res/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      navigatorKey: navigatorKey,
      theme: themeLight,
      darkTheme: themeDark,
      builder: (_, child) => AppWrapper(child!),
      home: const SplashScreen(),
    );
  }
}
