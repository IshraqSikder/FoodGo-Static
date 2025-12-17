import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/utils/colors.dart';

class BuildCategoryChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Color color;

  const BuildCategoryChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7.w, right: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected ? color : AppColors.text.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 10.r,
                  offset: Offset(0, 5.h),
                ),
              ]
            : [],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Colors.white
                : AppColors.text.withValues(alpha: 0.7),
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
