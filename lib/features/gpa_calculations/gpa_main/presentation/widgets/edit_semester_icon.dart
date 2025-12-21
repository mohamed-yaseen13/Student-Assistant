import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/edit_semester_bottom_sheet.dart';

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
      onSelected: (value) async {
        if (value == 1) {
          final semestersCubit = context.read<SemestersCubit>();
          final String oldSemesterName = semesterName;
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: semestersCubit,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                ),
                child: EditSemesterBottomSheet(initialName: oldSemesterName),
              ),
            ),
          );
          if (result != null) {
            await semestersCubit.editSemesterName(
              oldSemesterName,
              result['newSemesterName'],
            );
            semestersCubit.getAllSemesters();
          }
        } else if (value == 2) {
          await showDeleteDialog(
            context: context,
            content: 'Semester',
            isSingle: true,
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
