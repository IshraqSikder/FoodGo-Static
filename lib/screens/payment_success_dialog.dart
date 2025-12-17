import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodgo_static/controllers/product_controller.dart';
import 'package:foodgo_static/screens/home_screen.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:get/get.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 50.0.r,
              spreadRadius: -10.0,
              offset: Offset(0.0, 20.0.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Success Icon ---
            Container(
              height: 60.w,
              width: 60.w,
              decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0.r),
                  child: SvgPicture.asset(
                    'assets/icons/tic.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // --- Title ---
            Text(
              "Success !",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: AppColors.primaryRed,
              ),
            ),
            SizedBox(height: 10.h),

            // --- Description ---
            Text(
              "Your payment was successful.\nA receipt for this purchase has\nbeen sent to your email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.text,
                height: 1.5,
              ),
            ),
            SizedBox(height: 30.h),

            // --- Go Back Button ---
            SizedBox(
              width: double.infinity,
              height: 35.h,
              child: ElevatedButton(
                onPressed: () async {
                  Get.back();
                  Get.delete<ProductController>(force: true);

                  await Future.delayed(const Duration(milliseconds: 100));

                  Get.offAll(() => const HomeScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Go Back",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
