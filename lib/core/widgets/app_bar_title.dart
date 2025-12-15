import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.mainOrange,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
        child: Text(title, style: AppTextStyles.whiteColor24FontSize),
      ),
    );
  }
}
