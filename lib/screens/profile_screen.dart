import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodgo_static/controllers/profile_controller.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final double imageSize = 100.w;
    final double headerSpace = 160.h;

    final double imageTopPosition = headerSpace - (imageSize / 1.5);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryRed, AppColors.lighterPink],
          ),
          image: DecorationImage(
            image: const AssetImage('assets/images/chickenburger.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.primaryRed.withValues(alpha: 0.8),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // WHITE CURVED BODY CONTAINER
            Container(
              margin: EdgeInsets.only(top: headerSpace),
              padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Form Fields ---
                  Obx(() => _buildProfileField("Name", controller.name.value)),
                  SizedBox(height: 20.h),
                  Obx(
                    () => _buildProfileField("Email", controller.email.value),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => _buildProfileField(
                      "Delivery address",
                      controller.address.value,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => _buildProfileField(
                      "Password",
                      controller.password.value,
                      isPassword: true,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20.0.h, bottom: 10.h),
                    child: const Divider(color: AppColors.text, thickness: 0.2),
                  ),

                  // --- Menu Items ---
                  _buildMenuItem("Payment Details"),
                  SizedBox(height: 7.h),
                  _buildMenuItem("Order history"),

                  const Spacer(),

                  // --- Bottom Buttons ---
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.editProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textDark,
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.edit_square,
                                size: 15.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.logout,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            side: BorderSide(
                              color: AppColors.primaryRed,
                              width: 2.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Log out",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: AppColors.primaryRed,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.logout,
                                size: 15.sp,
                                color: AppColors.primaryRed,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // PROFILE IMAGE
            Positioned(
              top: imageTopPosition,
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 15.r,
                      spreadRadius: 5.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.0.r),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/user_profile.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // CUSTOM APP BAR / ICONS
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      // Settings Button
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    String value, {
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextField(
        readOnly: true,
        obscureText: isPassword,
        controller: TextEditingController(text: value),
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.text.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: AppColors.text.withValues(alpha: 0.2),
              width: 1.5.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: AppColors.text.withValues(alpha: 0.2),
              width: 1.5.w,
            ),
          ),
          suffixIcon: isPassword
              ? Icon(
                  Icons.lock,
                  size: 18.sp,
                  color: AppColors.text.withValues(alpha: 0.8),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.text,
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 24.sp,
            color: AppColors.text.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }
}
