import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/core/utils/colors.dart';

class GenderDropdown extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? selectedGender;
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null &&
        _genderOptions.contains(widget.initialValue)) {
      selectedGender = widget.initialValue;
    }
  }

  @override
  void didUpdateWidget(covariant GenderDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue && selectedGender == null) {
      if (widget.initialValue != null && _genderOptions.contains(widget.initialValue)) {
        selectedGender = widget.initialValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),

          DropdownButtonFormField<String>(
            value: selectedGender,
            hint: const Text('Select Gender'),

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.0,
                ),
              ),
            ),

            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
              widget.onChanged(newValue);
            },

            items: _genderOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            icon: const Icon(Icons.keyboard_arrow_down, size: 24),

            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
