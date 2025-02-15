import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qoruz/utils/app_colors.dart';
import 'package:qoruz/utils/app_constants.dart';
import 'package:qoruz/utils/extensions.dart';

class GradientAppbar extends StatelessWidget {
  final String title;
  const GradientAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double width = context.width();
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: statusBarHeight,
        left: width * AppConstants.horizontalPadding,
        right: width * AppConstants.horizontalPadding,
      ),
      height: kToolbarHeight + statusBarHeight,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFFFF7304),
            Color(0XFFFB2A77),
          ],
          transform: GradientRotation(20),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SvgPicture.asset(
            "assets/icons/market_place/menu.svg",
            height: 15,
          ),
        ],
      ),
    );
  }
}
