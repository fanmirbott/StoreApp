

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/core/utils/icons.dart';

class CardDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text.replaceAll('/', '');

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
        buffer.write('/');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class TextFieldCardData extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String hintText;
  final String? errorText;
  final Function(String)? onChanged;

  const TextFieldCardData({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isValid = errorText == null && controller.text.isNotEmpty;

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
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CardDateInputFormatter(),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 52.h, maxWidth: 165.w),
            hintText: hintText,
            errorText: errorText,
            suffixIcon: isValid
                ? SvgPicture.asset(
              AppIcons.correct,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.scaleDown,
            )
                : (errorText != null
                ? SvgPicture.asset(
              AppIcons.warningCircle,
              width: 24.w,
              height: 24.h,
              fit: BoxFit.scaleDown,
            )
                : null),
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
