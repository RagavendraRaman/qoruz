import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CircleProgressIndicatorWidget extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? strokeWidth;
  const CircleProgressIndicatorWidget({
    super.key,
    this.height,
    this.color,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
      width: height ?? 20,
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.transparent,
        strokeWidth: strokeWidth ?? 4.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.bottomNavselectedColor,
        ),
      ),
    );
  }
}
