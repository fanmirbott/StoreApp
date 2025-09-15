import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/core/utils/colors.dart';

class AuthButtonOtpSend extends StatelessWidget {
  const AuthButtonOtpSend({
    super.key,
    this.onTap,
    required this.text,
    required this.backgroundColor,
  });
  final VoidCallback? onTap;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 341.w,
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
