import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class SemesterGpa extends StatelessWidget {
  final SemesterModel semester;

  const SemesterGpa({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    final text = semester.courses.isNotEmpty
        ? semester.gpa.toStringAsFixed(2)
        : 'NEW';
    final color = semester.courses.isNotEmpty ? Colors.black : Colors.grey;
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp, color: color),
      textAlign: TextAlign.center,
    );
  }
}
