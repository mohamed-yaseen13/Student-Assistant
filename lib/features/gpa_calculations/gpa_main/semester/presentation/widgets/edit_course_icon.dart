import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/courses_cubit.dart';

class EditCourseIcon extends StatelessWidget {
  final String semesterName;
  final String courseName;

  const EditCourseIcon({
    super.key,
    required this.semesterName,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 1, child: Text('Edit')),
        const PopupMenuItem(value: 2, child: Text('Delete')),
      ],
      menuPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      onSelected: (value) async {
        if (value == 2) {
          await showDeleteDialog(
            context: context,
            content: 'Course',
            isSingle: true,
            onConfirm: () {
              context.read<CoursesCubit>().deleteCourses(semesterName, [
                courseName,
              ]);
              context.read<CoursesCubit>().getAllCourses(semesterName);
            },
            onCancel: () {},
          );
        }
      },
    );
  }
}
