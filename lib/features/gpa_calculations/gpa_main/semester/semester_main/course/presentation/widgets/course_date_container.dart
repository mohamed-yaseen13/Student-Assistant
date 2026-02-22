import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/widgets/data_container.dart';

class CourseDateContainer extends StatelessWidget {
  final String semesterName;
  final String courseName;

  const CourseDateContainer({
    super.key,
    required this.semesterName,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    final courseGrade = AppConstants
        .box
        .values
        .first
        .semesters[semesterName]!
        .courses[courseName]!
        .grade;
    return DataContainer(
      leftColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('You Got: ', style: TextStyle(fontSize: 18.sp))],
      ),
      rightColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(courseGrade, style: TextStyle(fontSize: 18.sp))],
      ),
    );
  }
}
