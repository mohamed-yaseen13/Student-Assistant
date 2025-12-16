import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';

class EditSemesterIcon extends StatelessWidget {
  final String semesterName;

  const EditSemesterIcon({super.key, required this.semesterName});

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
      onSelected: (value) {
        if (value == 2) {
          showDeleteDialog(
            context: context,
            content: 'Semester',
            onConfirm: () {
              context.read<SemestersCubit>().deleteSemesters([semesterName]);
              context.read<SemestersCubit>().getAllSemesters();
            },
            onCancel: () {},
          );
        }
      },
    );
  }
}
