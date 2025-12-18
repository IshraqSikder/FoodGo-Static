import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/screens/add_on_screen.dart';
import 'package:foodgo_static/screens/order_summary_screen.dart';
import 'package:foodgo_static/widgets/build_count_button.dart';
import 'package:foodgo_static/widgets/build_custom_appbar.dart';
import 'package:get/get.dart';
import 'package:foodgo_static/controllers/product_detail_controller.dart';
import 'package:foodgo_static/utils/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller = Get.put(
      ProductDetailController(productId),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight.h),
        child: const BuildCustomAppbar(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryRed),
          );
        }

        final product = controller.product.value;
        if (product == null) {
          return const Center(child: Text("Product not found"));
        }

        return Column(
          children: [
            // Image Area
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: Image.asset(product.image, fit: BoxFit.contain),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  bottom: 20.h,
                  top: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.sp),
                        Text(
                          " ${product.rating} - ${product.timeMinutes} mins",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    Spacer(),

                    // Spicy Slider & Portion
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Spicy Section
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Spicy",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: AppColors.textDark,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 10.h,),
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
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mild",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 80.w),
                                Text(
                                  "Hot",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Portion Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Portion",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: AppColors.textDark,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                BuildCountButton(
                                  icon: Icons.remove,
                                  onTap: controller.decrementQuantity,
                                ),
                                SizedBox(width: 15.w),
                                Text(
                                  "${controller.quantity.value}",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                BuildCountButton(
                                  icon: Icons.add,
                                  onTap: controller.incrementQuantity,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Bottom Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryRed,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Center(
                              child: Text(
                                "\$${controller.totalPrice.toStringAsFixed(2)}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                            ),
                            onPressed: () {
                              controller.addToCart();
                              Get.to(() => AddOnScreen());
                            },
                            child: Text(
                              "ORDER NOW",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
