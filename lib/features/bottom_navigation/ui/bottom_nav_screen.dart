import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qoruz/features/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:qoruz/features/market_place/ui/market_place_screen.dart';
import 'package:qoruz/features/static/ui/static_screen.dart';
import 'package:qoruz/utils/app_colors.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final BottomNavigationBloc bottomNavigationBloc = BottomNavigationBloc();
  int selectedIndex = 1;
  List screens = [
    const StaticScreen(screenName: "Explore"),
    const MarketPlaceScreen(),
    const StaticScreen(screenName: "Search"),
    const StaticScreen(screenName: "Activity"),
    const StaticScreen(screenName: "Profile"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      bloc: bottomNavigationBloc,
      builder: (context, state) {
        if (state is ChangeScreenState) {
          selectedIndex = state.screenId;
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: screens[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            selectedFontSize: 11,
            unselectedFontSize: 10,
            onTap: (index) {
              bottomNavigationBloc.add(ChangeScreenEvent(
                screenIndex: index,
              ));
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            selectedItemColor: AppColors.blackColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            unselectedItemColor: AppColors.bottomNavUnselectedColor,
            items: [
              BottomNavigationBarItem(
                backgroundColor: AppColors.whiteColor,
                icon: SvgPicture.asset(
                  "assets/icons/bottom_nav/explore.svg",
                ),
                label: 'Explore',
                activeIcon: SvgPicture.asset(
                  "assets/icons/bottom_nav/explore.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.bottomNavselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/bottom_nav/market_place.svg",
                    ),
                    indicatorWidget(),
                  ],
                ),
                label: 'Marketplace',
                activeIcon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/bottom_nav/market_place.svg",
                      colorFilter: const ColorFilter.mode(
                        AppColors.bottomNavselectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    indicatorWidget(),
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/bottom_nav/Search.svg",
                ),
                label: 'Search',
                activeIcon: SvgPicture.asset(
                  "assets/icons/bottom_nav/Search.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.bottomNavselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/bottom_nav/activity.svg",
                ),
                label: 'Activity',
                activeIcon: SvgPicture.asset(
                  "assets/icons/bottom_nav/activity.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.bottomNavselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/bottom_nav/profile.svg",
                ),
                label: 'Profile',
                activeIcon: SvgPicture.asset(
                  "assets/icons/bottom_nav/profile.svg",
                  colorFilter: const ColorFilter.mode(
                    AppColors.bottomNavselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget indicatorWidget() {
    return Positioned(
      right: -15,
      top: -5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.battomNavIndicationColor,
        ),
        child: const Padding(
          padding: EdgeInsets.all(3.0),
          child: Text(
            "NEW",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 6,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
