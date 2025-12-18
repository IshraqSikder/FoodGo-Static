import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/utils/colors.dart';

class IngredientCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  const IngredientCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 15.w),
        child: Stack(
          children: [
            // 1. BACKGROUND LAYER
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 50.h,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.textDark,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),

            // 2. FOREGROUND LAYER
            Column(
              children: [
                // Image Section (White Rounded Card)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: Image.asset(imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),

                // Text with Button Section
                Container(
                  height: 35.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Red Plus Button
                      Container(
                        width: 13.w,
                        height: 13.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryRed,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 10.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}