import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/features/obBoarding/widgets/onboarding_bottom_nav_bar.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 60.h,
                  left: 24.w,
                  child: Image.asset(
                    'assets/appImg/text.png',
                    width: 324.w,
                    height: 204.h,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/appImg/element1.png',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 100,
                  left: 80,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/appImg/onBoardingPhoto.png',
                      width: 358.w,
                      height: 697.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
          OnBoardingBottomNavBar(),
        ],
      ),
    );
  }
}
