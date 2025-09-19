import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/utils/colors.dart';

import '../../../core/routing/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.go(Routes.homePage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/appImg/element.png'),
              Positioned(
                top: 370.h,
                right: 128.w,
                child: Center(
                  child: Image.asset(
                    'assets/appImg/logo.png',
                    width: 134.w,
                    height: 134.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
