import 'package:flutter/material.dart';
import 'package:qoruz/features/splash/ui/splash_screen.dart';
import 'package:qoruz/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'qoruz',
      theme: ThemeData(
        fontFamily: "inter",
        scaffoldBackgroundColor: AppColors.whiteColor,
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColors.bottomNavselectedColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
