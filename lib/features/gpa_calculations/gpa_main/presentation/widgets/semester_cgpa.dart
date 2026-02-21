import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class SemesterCgpa extends StatelessWidget {
  final SemesterModel semester;

  const SemesterCgpa({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    if (semester.courses.isEmpty) {
      return Text(
        "NEW",
        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        textAlign: TextAlign.center,
      );
    }
    final double changed = semester.cgpaChanged;
    final double original = semester.cgpaOriginal;
    if (changed == original) {
      return Text(
        changed.toStringAsFixed(2),
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
        textAlign: TextAlign.center,
      );
    }
    final Color changedColor = changed > original ? Colors.green : Colors.red;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '${original.toStringAsFixed(2)} ',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          TextSpan(
            text: changed.toStringAsFixed(2),
            style: TextStyle(fontSize: 16.sp, color: changedColor),
          ),
        ],
      ),
    );
  }
}
