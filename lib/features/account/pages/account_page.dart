import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/core/utils/colors.dart';

import '../../../core/utils/icons.dart';
import '../../home/widgets/bottom_navigation_bar_app.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppIcons.backArrow),
        ),
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.bell),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(right: 24, left: 24),
        child: Column(
          children: [
            Divider(),
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.boxDuotone,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.primary400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
