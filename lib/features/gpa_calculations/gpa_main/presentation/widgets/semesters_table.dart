import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/models/student_model.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';
import 'package:student_assistant/core/models/semester_model.dart';
import 'package:student_assistant/core/widgets/delete_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semester_row.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semesters_table_header.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/cubits/gpa_calculations_cubit.dart';

class SemestersTable extends StatefulWidget {
  const SemestersTable({super.key});

  @override
  State<SemestersTable> createState() => _SemestersTableState();
}

class _SemestersTableState extends State<SemestersTable> {
  List<SemesterModel> selectedSemesters = [];
  bool isSelectionMode = false;

  void toggleSelection(SemesterModel semester) {
    setState(() {
      selectedSemesters.removeWhere((s) => s.name == semester.name);
      if (!selectedSemesters.any((s) => s.name == semester.name)) {
        selectedSemesters.add(semester);
      }
      isSelectionMode = selectedSemesters.isNotEmpty;
    });
  }

  void deleteSelectedSemesters() async {
    final semestersCubit = context.read<SemestersCubit>();
    await showDeleteDialog(
      context: context,
      content: selectedSemesters.length > 1 ? 'semesters' : 'Semester',
      isSingle: selectedSemesters.length == 1,
      onConfirm: () async {
        await semestersCubit.deleteSemesters(selectedSemesters);
      },
      onCancel: () {
        setState(() {
          selectedSemesters.clear();
          isSelectionMode = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        child: Column(
          children: [
            SemestersTableHeader(),
            verticalSpace(18),
            Expanded(
              child: BlocListener<SemestersCubit, SemestersState>(
                listenWhen: (previous, current) =>
                    current is SemestersDeleteSuccess,
                listener: (context, state) async {
                  if (state is SemestersDeleteSuccess) {
                    context.read<GpaCalculationsCubit>().calculateGpaAndCgpa();
                    setState(() {
                      selectedSemesters.clear();
                      isSelectionMode = false;
                    });
                  }
                },
                child: ValueListenableBuilder(
                  valueListenable: AppConstants.box.listenable(),
                  builder: (context, Box<StudentModel> box, _) {
                    final semesters = AppConstants
                        .box
                        .values
                        .first
                        .semesters
                        .values
                        .toList();
                    return ListView.separated(
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: semesters.length,
                      padding: EdgeInsets.only(bottom: 24.h),
                      separatorBuilder: (_, _) => verticalSpace(18),
                      itemBuilder: (context, index) {
                        final semester = semesters[index];
                        return SemesterRow(
                          index: index,
                          semester: semester,
                          isSelected: selectedSemesters.any(
                            (s) => s.name == semester.name,
                          ),
                          onLongPress: () => toggleSelection(semester),
                          onTap: () {
                            if (isSelectionMode) {
                              toggleSelection(semester);
                            } else {
                              context.pushNamed(
                                AppRoutes.semesterMainScreen,
                                arguments: {
                                  'semesterName': semester.name,
                                  'semesterIndex': semester.index,
                                },
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isSelectionMode
          ? DeleteButton(onPressed: deleteSelectedSemesters)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
