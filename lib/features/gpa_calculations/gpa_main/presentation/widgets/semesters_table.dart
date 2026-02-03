import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/widgets/delete_button.dart';
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
                listener: (context, state) {
                  if (state is SemestersDeleteSuccess) {
                    context.read<GpaCalculationsCubit>().calculateGpaAndCgpa();
                    setState(() {
                      selectedSemesters.clear();
                      isSelectionMode = false;
                    });
                  }
                },
                child: BlocBuilder<SemestersCubit, SemestersState>(
                  buildWhen: (previous, current) =>
                      current is SemestersGetAllSemestersLoading ||
                      current is SemestersGetAllSemestersSuccess ||
                      current is SemestersGetAllSemestersError,
                  builder: (context, state) {
                    if (state is SemestersGetAllSemestersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SemestersGetAllSemestersSuccess) {
                      return ListView.separated(
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: state.semesters.length,
                        padding: EdgeInsets.only(bottom: 24.h),
                        separatorBuilder: (_, _) => verticalSpace(18),
                        itemBuilder: (context, index) {
                          final semester = state.semesters[index];
                          return SemesterRow(
                            index: index,
                            semester: state.semesters[index],
                            isSelected: selectedSemesters.any(
                              (s) => s.name == semester.name,
                            ),
                            onLongPress: () => toggleSelection(semester),
                            onTap: () {
                              if (isSelectionMode) {
                                toggleSelection(semester);
                              } else {
                                final gpaCubit = context
                                    .read<GpaCalculationsCubit>();
                                context.pushNamed(
                                  AppRoutes.semesterMainScreen,
                                  arguments: {
                                    'semesterName': state.semesters[index].name,
                                    'semesterIndex':
                                        state.semesters[index].index,
                                    'gpaCubit': gpaCubit,
                                  },
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                    if (state is SemestersGetAllSemestersError) {
                      return Center(
                        child: Text(
                          state.apiErrorModel.message ??
                              'Failed to get your semesters',
                        ),
                      );
                    }
                    return const SizedBox.shrink();
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
