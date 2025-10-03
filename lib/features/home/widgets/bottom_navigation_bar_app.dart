import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../../../core/routing/routes.dart';

class BottomNavigationBarApp extends StatelessWidget {
  const BottomNavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Container(
      width: double.infinity,
      height: 86.h,
      decoration:  BoxDecoration(color: AppColors.white,
      border: Border(top: BorderSide(color: AppColors.primary100)) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(
            context,
            icon: AppIcons.home,
            label: "Home",
            route: Routes.homePage,
            isSelected: location == Routes.homePage,
          ),
          _navItem(
            context,
            icon: AppIcons.search,
            label: "Search",
            route: Routes.searchPage,
            isSelected: location == Routes.searchPage,
          ),
          _navItem(
            context,
            icon: AppIcons.heart,
            label: "Saved",
            route: Routes.savedPage,
            isSelected: location == Routes.savedPage,
          ),
          _navItem(
            context,
            icon: AppIcons.cart,
            label: "Cart",
            route: Routes.cartPage,
            isSelected: location == Routes.cartPage,
          ),
          _navItem(
            context,
            icon: AppIcons.user,
            label: "Account",
            route: Routes.accountPage,
            isSelected: location == Routes.accountPage,
          ),
        ],
      ),
    );
  }

  Widget _navItem(
      BuildContext context, {
        required String icon,
        required String label,
        required String route,
        required bool isSelected,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        context.push(route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.primary : AppColors.primary500,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? AppColors.primary : AppColors.primary500,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
