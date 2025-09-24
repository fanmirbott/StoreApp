import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors.dart';

class CounterRow extends StatefulWidget {
  const CounterRow({super.key});

  @override
  State<CounterRow> createState() => _CounterRowState();
}

class _CounterRowState extends State<CounterRow> {
  int count = 1;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: decrement,
          child: Container(
            width: 23.w,
            height: 23.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary200),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: const Icon(Icons.remove, size: 16),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: increment,
          child: Container(
            width: 23.w,
            height: 23.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary200),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: const Icon(Icons.add, size: 16),
          ),
        ),
      ],
    );
  }
}
