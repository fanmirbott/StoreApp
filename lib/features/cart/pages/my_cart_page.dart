import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/home/widgets/bottom_navigation_bar_app.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.cartDuotone,
              width: 64.w,
              height: 64.h,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Your Cart Is Empty!',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'When you add products, they’ll',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primary500,
              ),
            ),
            Text(
              'appear here.',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primary500,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
