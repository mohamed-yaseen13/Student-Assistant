import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

class SemesterRow extends StatelessWidget {
  final int index;
  final SemesterModel semester;

  const SemesterRow({super.key, required this.index, required this.semester});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.sp),
        color: AppColors.lightOrange,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              semester.name,
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              '${semester.gpa}',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              '${semester.cgpaOriginal}',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 2, child: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
