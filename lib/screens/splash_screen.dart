import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/screens/home_screen.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate after delay
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.off(() => const HomeScreen()),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [AppColors.lighterPink, AppColors.vibrantRed],
                stops: [0.1, 0.5],
              ),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 250.h),
                child: Text(
                  "Foodgo",
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 35.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Multilayer Burger Image
          Positioned(
            bottom: -30.h,
            left: -250.w,
            right: 0,
            child: Image.asset(
              'assets/images/multilayerburger.png',
              fit: BoxFit.contain,
              width: 180.w,
              height: 200.h,
            ),
          ),

          // Veggie Burger Image with Shadow
          Positioned(
            bottom: -20.h,
            left: 5.w,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    spreadRadius: 0,
                    blurRadius: 50.r,
                    blurStyle: BlurStyle.normal,
                    offset: Offset(-90.w, 30.h),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/veggieburger.png',
                fit: BoxFit.contain,
                width: 150.w,
                height: 150.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
