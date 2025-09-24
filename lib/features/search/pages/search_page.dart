import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/features/home/widgets/bottom_navigation_bar_app.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
          'Search',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcons.bell)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(right: 24, left: 24),
          child: Column(
            children: [
              Row(
                spacing: 14,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(40.r),
                        onTap: () {},
                        child: SvgPicture.asset(
                          AppIcons.mic,
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      prefixIcon: SvgPicture.asset(
                        AppIcons.search,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.primary200,
                      ),
                      hintText: 'Search for clothes...',
                      constraints: BoxConstraints(
                        maxHeight: 52.h,
                        maxWidth: 341.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: AppColors.primary100,
                          width: 0.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      'Clear all',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
