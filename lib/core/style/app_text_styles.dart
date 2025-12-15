import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class AppTextStyles {
  static TextStyle whiteColor32FontSizeBold = TextStyle(
    color: Colors.white,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteColor32FontSize = TextStyle(
    color: Colors.white,
    fontSize: 32.sp,
  );

  static TextStyle whiteColor24FontSize = TextStyle(
    color: Colors.white,
    fontSize: 24.sp,
  );

  static TextStyle whiteColor16FontSize = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
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

  static TextStyle blackColor16FontSize = TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
  );

  static TextStyle blackColor18FontSize600Weight = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle lightOrange16FontSize = TextStyle(
    color: AppColors.lightOrange,
    fontSize: 16.sp,
  );
}
