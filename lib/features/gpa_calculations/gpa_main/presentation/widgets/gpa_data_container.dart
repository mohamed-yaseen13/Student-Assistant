import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/widgets/data_container.dart';

class GpaDataContainer extends StatelessWidget {
  const GpaDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      leftColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cumulative GPA: ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Total Credits: ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Max CGPA you can get: ', style: TextStyle(fontSize: 18.sp)),
        ],
      ),
      rightColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('2.48', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text(
            '137',
            style: TextStyle(fontSize: 18.sp, color: AppColors.mainOrange),
          ),
          verticalSpace(12),
          Text(
            '2.76',
            style: TextStyle(fontSize: 18.sp, color: AppColors.mainOrange),
          ),
        ],
      ),
    );
  }
}
