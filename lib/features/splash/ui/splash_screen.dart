import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoruz/features/bottom_navigation/ui/bottom_nav_screen.dart';
import 'package:qoruz/features/splash/bloc/splash_bloc.dart';
import 'package:qoruz/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc splashBloc = SplashBloc();

  @override
  void initState() {
    splashBloc.add(SplashInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: splashBloc,
      listener: (context, state) {
        if (state is SplashNavigationState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => const BottomNavScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.choiceSelectedColor,
        body: Center(
          child: Image.asset(
            "assets/icons/app_logo/qoruz_logo.png",
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
