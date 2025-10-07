import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/colors.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _values = const RangeValues(0, 19);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Price",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            Text(
              "\$${_values.start.toInt()} - \$${_values.end.toInt()}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primary500,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: _values,
          min: 0,
          max: 100,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.primary400,
          onChanged: (RangeValues newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
      ],
    );
  }
}
