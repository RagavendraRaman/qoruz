import 'package:flutter/material.dart';
import 'package:qoruz/reusable_widgets/gradient_appbar.dart';

class StaticScreen extends StatelessWidget {
  final String screenName;
  const StaticScreen({
    super.key,
    required this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientAppbar(title: screenName),
          const Expanded(
            child: Center(
              child: Text(
                "Oops! No Data Found",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
