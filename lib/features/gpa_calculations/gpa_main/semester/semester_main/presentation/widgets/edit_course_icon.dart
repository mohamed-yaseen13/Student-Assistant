import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/edit_course_bottom_sheet.dart';

class EditCourseIcon extends StatelessWidget {
  final String semesterName;
  final int semesterIndex;
  final CourseModel course;

  const EditCourseIcon({
    super.key,
    required this.semesterName,
    required this.semesterIndex,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final coursesCubit = context.read<CoursesCubit>();
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 1, child: Text('Edit')),
        const PopupMenuItem(value: 2, child: Text('Delete')),
      ],
      menuPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      onSelected: (value) async {
        if (value == 1) {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: coursesCubit,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                ),
                child: EditCourseBottomSheet(
                  initialCourseName: course.name,
                  initialCourseGrade: course.grade,
                  initialCourseCredits: course.credits,
                ),
              ),
            ),
          );
          if (result != null) {
            final bool existsBefore = await coursesCubit.checkRepeatedCourse(
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
                            child: const Text('Edit'),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false;
              if (!proceed) return;
            }
            await coursesCubit.editCourse(
              semesterIndex: semesterIndex,
              semesterName: semesterName,
              courseIndex: course.index,
              courseName: result['name'],
              grade: result['grade'],
              credits: result['credits'],
              oldCourseName: course.name,
              isRepeated: existsBefore,
            );
          }
        } else if (value == 2) {
          await showDeleteDialog(
            context: context,
            content: 'Course',
            onConfirm: () async {
              await coursesCubit.deleteCourses(semesterName, [
                course,
              ], semesterIndex);
            },
            onCancel: () {},
          );
        }
      },
    );
  }
}
