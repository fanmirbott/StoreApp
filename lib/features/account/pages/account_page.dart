import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
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
              onTap: () {},
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {},
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {},
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {},
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {},
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {},
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {
                context.push(Routes.helpCenterPage);
              },
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
                    SizedBox(
                      width: 16.w,
                    ),
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      width: 341.w,
                      height: 336.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(20.r),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppIcons.warning,
                            width: 78.w,
                            height: 78.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'Logout?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: AppColors.primary,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: AppColors.primary500,
                              decoration: TextDecoration.none,
                              letterSpacing: -0.9,
                            ),
                          ),
                          SizedBox(height: 24.h,),
                          ButtonWidget(
                            onTap: () {
                              context.push(Routes.loginPage);
                            },
                            text: 'Yes, Logout',
                            buttonColor: AppColors.red,
                            border: Border.all(color: AppColors.red),
                            textColor: AppColors.white,
                          ),
                          SizedBox(height: 12.h,),
                          ButtonWidget(
                            onTap: () {
                              context.pop(context);
                            },
                            text: 'No, Cancel',
                            buttonColor: AppColors.white,
                            border: Border.all(color: AppColors.primary200),
                            textColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
                    SizedBox(
                      width: 16.w,
                    ),
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
