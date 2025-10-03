import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldAndText extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Widget? prefixWidget;

  const TextFieldAndText({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    bool isValid = errorText == null && controller.text.isNotEmpty;

    const Color primary200 = Colors.grey;
    const String correctIcon = 'assets/icons/correct.svg';
    const String warningCircleIcon = 'assets/icons/warning_circle.svg';


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType:
          prefixWidget != null ? TextInputType.phone : TextInputType.text,

          onChanged: onChanged,
          decoration: InputDecoration(
            prefix: prefixWidget,

            hintText: hintText,
            hintStyle: const TextStyle(color: primary200),
            errorText: errorText,
            suffixIcon:
            suffixIcon ??
                (isValid
                    ? SvgPicture.asset(
                  correctIcon,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.scaleDown,
                )
                    : (errorText != null
                    ? SvgPicture.asset(
                  warningCircleIcon,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.scaleDown,
                )
                    : null)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red
                    : (isValid ? Colors.green : Colors.grey),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red
                    : (isValid ? Colors.green : Colors.blue),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}