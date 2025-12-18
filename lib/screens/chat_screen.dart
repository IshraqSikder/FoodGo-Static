import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodgo_static/controllers/chat_controller.dart';
import 'package:foodgo_static/models/message.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  if (msg.isTimeSeparator) {
                    return _buildTimeSeparator(msg.text);
                  }
                  return _buildMessageRow(msg);
                },
              );
            }),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black87, size: 28.sp),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: SvgPicture.asset(
            "assets/icons/filter.svg",
            fit: BoxFit.contain,
            width: 12.w,
            height: 12.h,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSeparator(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.text.withValues(alpha: 0.3),
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageRow(Message msg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: msg.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Support Avatar (Left side)
          if (!msg.isMe) ...[
            CircleAvatar(
              backgroundColor: AppColors.textDark,
              radius: 20.r,
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 18.w,
                height: 18.h,
              ),
            ),
            SizedBox(width: 10.w),
          ],

          // The Message
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.65.sw),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: msg.isMe
                    ? AppColors.primaryRed
                    : const Color(0xFFF1F2F4),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  color: msg.isMe ? Colors.white : AppColors.textDark,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),

          // User Avatar (Right side)
          if (msg.isMe) ...[
            SizedBox(width: 10.w),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryRed, width: 2.w),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user_profile.jpg",),
                radius: 20.r,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(20.r),
      child: Stack(
        children: [
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 2.r,
                  blurRadius: 10.r,
                  offset: Offset(0, 5.h),
                ),
              ],
            ),
            child: TextField(
              controller: controller.textInputController,
              decoration: InputDecoration(
                hintText: "Type here...",
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  color: AppColors.text.withValues(alpha: 0.3),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 15.w,
                  right: 50.w,
                  bottom: 20.h,
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: AppColors.text,
                fontSize: 15.sp,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: controller.sendMessage,
              child: Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryRed.withValues(alpha: 0.4),
                      blurRadius: 10.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
