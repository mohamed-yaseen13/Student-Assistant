import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/add_semester_bottom_sheet.dart';

class AddSemesterButton extends StatelessWidget {
  const AddSemesterButton({super.key});

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
          final gpaMainCubit = context.read<SemestersCubit>();
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: gpaMainCubit,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                ),
                child: const AddSemesterBottomSheet(),
              ),
            ),
          );
          if (result != null) {
            gpaMainCubit.addSemester(result['name']);
          }
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
