import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/controllers/order_controller.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:foodgo_static/widgets/build_custom_appbar.dart';
import 'package:foodgo_static/widgets/build_payment_card.dart';
import 'package:get/get.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight.h),
        child: const BuildCustomAppbar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order summary",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),

              // --- Summary Section ---
              _buildSummaryRow(
                "Order",
                "\$${controller.orderValue.toStringAsFixed(2)}",
              ),
              _buildSummaryRow(
                "Taxes",
                "\$${controller.taxes.toStringAsFixed(2)}",
              ),
              _buildSummaryRow(
                "Delivery fees",
                "\$${controller.deliveryFees.toStringAsFixed(2)}",
              ),
              Divider(
                height: 20.h,
                color: AppColors.text.withValues(alpha: 0.15),
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    "\$${controller.total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estimated delivery time:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "15 - 30mins",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // --- Payment Methods Section ---
              Text(
                "Payment methods",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 15.h),

              // Payment Cards
              Obx(
                () => Column(
                  children: [
                    BuildPaymentCard(
                      index: 0,
                      name: "Credit card",
                      number: "5105 **** **** 0505",
                      logoUrl: "assets/images/mastercard.png",
                      isSelected: controller.selectedPaymentMethod.value == 0,
                    ),
                    SizedBox(height: 15.h),
                    BuildPaymentCard(
                      index: 1,
                      name: "Debit card",
                      number: "3566 **** **** 0505",
                      logoUrl: "assets/images/visa.png",
                      isSelected: controller.selectedPaymentMethod.value == 1,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              // Save Details Checkbox
              Obx(
                () => Row(
                  children: [
                    SizedBox(
                      height: 15.h,
                      width: 15.w,
                      child: Checkbox(
                        value: controller.saveCardDetails.value,
                        activeColor: AppColors.primaryRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        onChanged: controller.toggleSaveCard,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Save card details for future payments",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // --- Bottom Total & Pay Button ---
              Padding(
                padding: EdgeInsets.only(bottom: 20.0.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total price",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: AppColors.text,
                            fontSize: 12.sp,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "\$",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRed,
                                  fontSize: 24.sp,
                                ),
                              ),
                              TextSpan(
                                text: controller.total.toStringAsFixed(2),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 24.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50.h,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.placeOrder,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Pay Now",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated Helper Method
  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: AppColors.text,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: AppColors.text,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
