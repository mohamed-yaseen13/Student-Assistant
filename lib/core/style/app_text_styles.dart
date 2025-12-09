import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class AppTextStyles {
  static TextStyle whiteColor32FontSizeBold = TextStyle(
    color: Colors.white,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteColor16FontSize = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
  );

  static TextStyle blackColor16FontSizeSemiBold = TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle grayColor16FontSizeRegular = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
  );

  static TextStyle mainOrangeColor16FontSize = TextStyle(
    color: AppColors.mainOrange,
    fontSize: 16.sp,
  );
}
