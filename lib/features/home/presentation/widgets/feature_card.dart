import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.sp),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.sp),
          child: Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: feature.color,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Icon(feature.icon, color: Colors.white, size: 28.sp),
                ),
                horizontalSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.title,
                        style: AppTextStyles.blackColor18FontSize600Weight,
                      ),
                      const SizedBox(height: 4),
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
      ),
    );
  }
}

class FeatureItem {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  FeatureItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
