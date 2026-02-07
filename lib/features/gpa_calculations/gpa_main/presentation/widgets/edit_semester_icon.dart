import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/edit_semester_bottom_sheet.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

class EditSemesterIcon extends StatelessWidget {
  final SemesterModel semester;

  const EditSemesterIcon({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    final semestersCubit = context.read<SemestersCubit>();
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
          final String oldSemesterName = semester.name;
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
          }
        } else if (value == 2) {
          await showDeleteDialog(
            context: context,
            content: 'Semester',
            onConfirm: () async {
              await semestersCubit.deleteSemesters([semester]);
            },
            onCancel: () {},
          );
        }
      },
    );
  }
}
