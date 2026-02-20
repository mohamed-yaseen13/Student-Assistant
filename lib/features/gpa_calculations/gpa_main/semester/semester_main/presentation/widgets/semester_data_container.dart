import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/models/student_model.dart';
import 'package:student_assistant/core/widgets/data_container.dart';

class SemesterDataContainer extends StatelessWidget {
  final String semesterName;

  const SemesterDataContainer({super.key, required this.semesterName});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      leftColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attempted Credits : ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Earned Credits : ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('GPA', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Max GPA you can get', style: TextStyle(fontSize: 16.sp)),
        ],
      ),
      rightColumn: ValueListenableBuilder(
        valueListenable: AppConstants.box.listenable(),
        builder: (context, Box<StudentModel> box, _) {
          final semester =
              AppConstants.box.values.first.semesters[semesterName]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${semester.attemptedCredits}',
                style: TextStyle(fontSize: 18.sp),
              ),
              verticalSpace(12),
              Text(
                '${semester.earnedCredits}',
                style: TextStyle(fontSize: 18.sp, color: Colors.green),
              ),
              verticalSpace(12),
              Text(
                semester.gpa.toStringAsFixed(2),
                style: TextStyle(fontSize: 18.sp),
              ),
              verticalSpace(12),
              Text(
                semester.maxGpa.toStringAsFixed(2),
                style: TextStyle(fontSize: 18.sp),
              ),
            ],
          );
        },
      ),
    );
  }
}
