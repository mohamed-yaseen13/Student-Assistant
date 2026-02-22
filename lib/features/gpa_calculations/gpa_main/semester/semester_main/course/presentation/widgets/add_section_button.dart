import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/cubit/sections_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/widgets/add_section_bottom_sheet.dart';

class AddSectionButton extends StatelessWidget {
  final String semesterName;
  final String courseName;

  const AddSectionButton({
    super.key,
    required this.courseName,
    required this.semesterName,
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
          final sectionsCubit = context.read<SectionsCubit>();
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: sectionsCubit,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                ),
                child: AddSectionBottomSheet(),
              ),
            ),
          );
          if (result != null) {
            sectionsCubit.addSection(
              semesterName: semesterName,
              courseName: courseName,
              sectionName: result['sectionName'],
              got: result['got'],
              from: result['from'],
            );
          }
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
