import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/edit_semester_icon.dart';

class SemesterRow extends StatelessWidget {
  final int index;
  final SemesterModel semester;
  final bool isSelected;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  const SemesterRow({
    super.key,
    required this.index,
    required this.semester,
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
            Expanded(
              flex: 2,
              child: EditSemesterIcon(semesterName: semester.name),
            ),
          ],
        ),
      ),
    );
  }
}
