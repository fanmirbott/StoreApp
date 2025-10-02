import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/colors.dart';

class HelpCenterButton extends StatelessWidget {
  const HelpCenterButton({ required this.onTap, super.key, required this.icon, required this.text,});
  final VoidCallback onTap;
  final String icon;

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 341.w,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.primary100,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 20),
          child: Row(
            spacing: 12,
            children: [
              SvgPicture.asset(icon, width: 24.w, height: 24,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
