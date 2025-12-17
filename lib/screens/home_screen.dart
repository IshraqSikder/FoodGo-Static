import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodgo_static/controllers/product_controller.dart';
import 'package:foodgo_static/screens/chat_screen.dart';
import 'package:foodgo_static/screens/profile_screen.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:foodgo_static/widgets/build_category_chip.dart';
import 'package:get/get.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: false,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90.h,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Foodgo",
              style: TextStyle(
                color: AppColors.textDark,
                fontFamily: 'Lobster',
                fontSize: 30.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Order your favourite food!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.text,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(18.0.r),
            child: CircleAvatar(
              radius: 25.r,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SEARCH BAR SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            spreadRadius: 2.r,
                            blurRadius: 10.r,
                            offset: Offset(0, 3.h),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: SizedBox(
                            width: 18.w,
                            height: 18.h,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/search.svg',
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.textDark,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 1.h,
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 45.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/settings-sliders.svg',
                        width: 15.w,
                        height: 15.h,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // CATEGORIES SECTION
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: const [
                    BuildCategoryChip(
                      text: 'All',
                      isSelected: true,
                      color: AppColors.primaryRed,
                    ),
                    BuildCategoryChip(
                      text: 'Combos',
                      isSelected: false,
                      color: AppColors.primaryRed,
                    ),
                    BuildCategoryChip(
                      text: 'Sliders',
                      isSelected: false,
                      color: AppColors.primaryRed,
                    ),
                    BuildCategoryChip(
                      text: 'Classic',
                      isSelected: false,
                      color: AppColors.primaryRed,
                    ),
                    BuildCategoryChip(
                      text: 'Special',
                      isSelected: false,
                      color: AppColors.primaryRed,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // FOOD GRID SECTION
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.productList.isEmpty) {
                  return const Center(child: Text("No items found"));
                }
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10.r),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: controller.productList.length,
                    itemBuilder: (context, index) {
                      final product = controller.productList[index];
                      return GestureDetector(
                        onTap: () => Get.to(
                          () => ProductDetailScreen(productId: product.id),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 10.r,
                                spreadRadius: 0,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 110.h,
                                clipBehavior: Clip.none,
                                child: Image.asset(
                                  product.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${product.name.split(' ').first}\n',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: product.name
                                              .split(' ')
                                              .skip(1)
                                              .join(' '),
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "${product.rating}",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset(
                                        'assets/icons/fav.svg',
                                        width: 13.w,
                                        height: 13.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION BAR
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryRed,
        elevation: 4.0,
        shape: const CircleBorder(),
        child: Icon(Icons.add, size: 30.sp, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryRed,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.r,
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/icons/home.svg',
                width: 20.w,
                height: 20.h,
              ),
              GestureDetector(
                onTap: () => Get.to(() => const ProfileScreen()),
                child: SvgPicture.asset(
                  'assets/icons/user.svg',
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              SizedBox(width: 50.w),
              GestureDetector(
                onTap: () => Get.to(() => ChatScreen()),
                child: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 20.w,
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
