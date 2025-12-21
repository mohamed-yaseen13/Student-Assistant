import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/add_course_bottom_sheet.dart';

class AddCourseButton extends StatelessWidget {
  final String semesterName;

  const AddCourseButton({super.key, required this.semesterName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
      child: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.lightOrange,
        onPressed: () async {
          final coursesCubit = context.read<CoursesCubit>();
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: coursesCubit,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                ),
                child: const AddCourseBottomSheet(),
              ),
            ),
          );
          if (result != null) {
            coursesCubit.addCourse(
              semesterName,
              result['name'],
              result['credits'],
              result['grade'],
            );
          }
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
