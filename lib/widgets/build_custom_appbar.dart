import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildCustomAppbar extends StatelessWidget {
  const BuildCustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
        onPressed: () => Get.back(),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 7.0.w),
          child: IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: 28.sp),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
