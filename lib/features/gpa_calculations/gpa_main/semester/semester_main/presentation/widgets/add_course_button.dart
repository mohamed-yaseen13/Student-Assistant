import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/add_course_bottom_sheet.dart';

class AddCourseButton extends StatelessWidget {
  final String semesterName;
  final int semesterIndex;

  const AddCourseButton({
    super.key,
    required this.semesterName,
    required this.semesterIndex,
  });

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
          if (result == null) return;
          final bool existsBefore = coursesCubit.checkRepeatedCourse(
            result['name'],
            semesterIndex,
          );
          if (existsBefore) {
            await Future.microtask(() {});
            if (!context.mounted) return;
            final bool proceed =
                await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      title: const Text('Repeated Course'),
                      content: const Text(
                        'This course already exists in a previous semester.\n'
                        'Do you want to add it again?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop(true);
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  },
                ) ??
                false;
            if (!proceed) return;
          }
          await coursesCubit.addCourse(
            semesterName: semesterName,
            courseName: result['name'],
            credits: result['credits'],
            grade: result['grade'],
            semesterIndex: semesterIndex,
            isRepeated: existsBefore,
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
