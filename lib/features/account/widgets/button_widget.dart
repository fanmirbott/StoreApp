import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.onTap,
    super.key,
    required this.text,
    required this.buttonColor,
    required this.border,
    required this.textColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final BoxBorder border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 293.w,
        height: 54.h,
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadiusGeometry.circular(10.r),
          border: border,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
