import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/controllers/add_on_controller.dart';
import 'package:foodgo_static/screens/order_summary_screen.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:foodgo_static/widgets/ingredient_card.dart';
import 'package:get/get.dart';

class AddOnScreen extends StatelessWidget {
  const AddOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddOnController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: 24.sp),
            onPressed: () {},
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h,),
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- TOP SECTION (Image + Controls) ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Big Burger Image
                      Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/addon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // SizedBox(width: 10.w), // Small gap instead of Spacer

                      Spacer(),

                      // Right: Controls
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Customize ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Your Burger to Your Tastes. Ultimate Experience",
                                    style: TextStyle(
                                      color: AppColors.textDark.withValues(alpha: 0.8),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),

                            // Spicy Slider
                            Text(
                              "Spicy",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Obx(
                                  () => SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: AppColors.primaryRed,
                                  inactiveTrackColor: Colors.grey[200],
                                  thumbColor: AppColors.primaryRed,
                                  trackHeight: 4.h,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.r,
                                  ),
                                  overlayShape: SliderComponentShape.noOverlay,
                                ),
                                child: Slider(
                                  value: controller.spicyValue.value,
                                  onChanged: (val) =>
                                  controller.spicyValue.value = val,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mild",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  "Hot",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryRed,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30.h),

                            // Portion Control
                            Text(
                              "Portion",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                _buildPortionButton(
                                  Icons.remove,
                                  AppColors.primaryRed,
                                  controller.decrementPortion,
                                ),
                                SizedBox(width: 15.w),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                  child: Obx(
                                        () => Text(
                                      "${controller.portionCount.value}",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                _buildPortionButton(
                                  Icons.add,
                                  AppColors.primaryRed,
                                  controller.incrementPortion,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  // --- TOPPINGS SECTION ---
                  Text(
                    "Toppings",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 110.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.toppings.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final item = controller.toppings[index];
                        return IngredientCard(
                          name: item.name,
                          imagePath: item.image,
                          onTap: () {},
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // --- SIDE OPTIONS SECTION ---
                  Text(
                    "Side options",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 110.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.sideOptions.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final item = controller.sideOptions[index];
                        return IngredientCard(
                          name: item.name,
                          imagePath: item.image,
                          onTap: () {},
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),

          SizedBox(height: 30.h,),

          // --- BOTTOM BAR ---
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryRed,
                              fontSize: 28.sp,
                            ),
                          ),
                          TextSpan(
                            text: controller.totalPrice.toStringAsFixed(2),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 160.w,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(OrderSummaryScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortionButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 35.w,
        height: 35.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}