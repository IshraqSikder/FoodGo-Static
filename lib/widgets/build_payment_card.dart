import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/controllers/order_controller.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:get/get.dart';

class BuildPaymentCard extends StatelessWidget {
  final int index;
  final String name;
  final String number;
  final String logoUrl;
  final bool isSelected;

  const BuildPaymentCard({
    super.key,
    required this.index,
    required this.name,
    required this.number,
    required this.logoUrl,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();

    return GestureDetector(
      onTap: () => controller.selectPaymentMethod(index),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textDark : AppColors.background,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 15.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50.w,
              height: 45.h,
              child: Image.asset(logoUrl, fit: BoxFit.contain),
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  number,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white54
                        : AppColors.text.withValues(alpha: 0.8),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.white,
              size: 25.sp,
            ),
          ],
        ),
      ),
    );
  }
}
