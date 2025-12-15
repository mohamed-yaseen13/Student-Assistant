import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';

class FeatureCard extends StatelessWidget {
  final FeatureItem feature;
  final VoidCallback onTap;

  const FeatureCard({super.key, required this.feature, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.sp),
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              SvgPicture.asset(feature.iconPath, width: 48.sp, height: 48.sp),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: AppTextStyles.blackColor18FontSize600Weight,
                    ),
                    verticalSpace(4),
                    Text(
                      feature.description,
                      style: AppTextStyles.grayColor16FontSizeRegular,
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
}

class FeatureItem {
  final String title;
  final String description;
  final String iconPath;

  FeatureItem({
    required this.title,
    required this.description,
    required this.iconPath,
  });
}
