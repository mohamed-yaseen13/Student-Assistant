import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semester_row.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semesters_table_header.dart';

class SemestersTable extends StatelessWidget {
  const SemestersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          SemestersTableHeader(),
          verticalSpace(8),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(children: [SemesterRow(), verticalSpace(12)]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
