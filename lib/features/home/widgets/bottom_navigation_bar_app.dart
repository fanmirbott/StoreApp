import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../../account/pages/account_page.dart';
import '../../cart/pages/my_cart_page.dart';
import '../../saved/pages/saved_items_page.dart';
import '../../search/pages/search_page.dart';
import '../pages/home_page.dart';

class BottomNavigationBarApp extends StatefulWidget {
  const BottomNavigationBarApp({super.key});

  @override
  State<BottomNavigationBarApp> createState() => _BottomNavigationBarAppState();
}

class _BottomNavigationBarAppState extends State<BottomNavigationBarApp> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> bottomNavItems = [
    {"icon": AppIcons.home, "page": HomePage()},
    {"icon": AppIcons.search, "page": SearchPage()},
    {"icon": AppIcons.heart, "page": SavedItemsPage()},
    {"icon": AppIcons.cart, "page": MyCartPage()},
    {"icon": AppIcons.user, "page": AccountPage()},
  ];
  List items = [
    'Home',
    'Search',
    'Saved',
    'Cart',
    'Account'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 86,
      decoration: BoxDecoration(color: AppColors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(bottomNavItems.length, (index) {
          final item = bottomNavItems[index];
          final isSelected = currentIndex == index;
          return InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    item["icon"],
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.primary : AppColors.primary500,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(items[index]),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
