import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/edit_course_icon.dart';

class CourseRow extends StatelessWidget {
  final int index;
  final CourseModel course;
  final bool isSelected;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final String semesterName;
  final int semesterIndex;

  const CourseRow({
    super.key,
    required this.index,
    required this.course,
    required this.semesterName,
    required this.semesterIndex,
    this.isSelected = false,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.sp),
          color: isSelected ? Colors.blue.shade100 : AppColors.lightOrange,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: isSelected
                  ? CircleAvatar(
                      radius: 12.sp,
                      backgroundColor: Colors.blue,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    )
                  : Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
            ),
            Expanded(
              flex: 7,
              child: Text(
                course.name,
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
                overflow: .ellipsis,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                course.grade,
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                '${course.credits}',
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: EditCourseIcon(
                semesterName: semesterName,
                courseName: course.name,
                semesterIndex: semesterIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
