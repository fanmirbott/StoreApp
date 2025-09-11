import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/core/utils/colors.dart';

class TextFieldAndText extends StatelessWidget {
  const TextFieldAndText({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String text;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColors.primary,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary100,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary100,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary100,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.primary400
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
