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
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
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
            ),
            Divider(
              height: 8.h,
              thickness: 8,
              color: AppColors.primary100,
            ),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.details,
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
                      'My Details',
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
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.address,
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
                      'Address Book',
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
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.cardDuotone,
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
                      'Payment Methods',
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
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.bell,
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
                      'Notifications',
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
            ),
            Divider(
              height: 8.h,
              thickness: 8,
              color: AppColors.primary100,
            ),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.question,
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
                      'FAQs',
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
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.headphones,
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
                      'Help Center',
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
            ),
            Divider(
              height: 8.h,
              thickness: 8,
              color: AppColors.primary100,
            ),
            InkWell(
              onTap: (){},
              child: SizedBox(
                height: 57.h,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.logout,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        Colors.red,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
