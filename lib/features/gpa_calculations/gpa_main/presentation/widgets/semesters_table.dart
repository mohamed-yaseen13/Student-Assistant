import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semester_row.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semesters_table_header.dart';

class SemestersTable extends StatefulWidget {
  const SemestersTable({super.key});

  @override
  State<SemestersTable> createState() => _SemestersTableState();
}

class _SemestersTableState extends State<SemestersTable> {
  List<String> selectedSemesters = [];
  bool isSelectionMode = false;

  void toggleSelection(String semesterName) {
    setState(() {
      if (selectedSemesters.contains(semesterName)) {
        selectedSemesters.remove(semesterName);
      } else {
        selectedSemesters.add(semesterName);
      }
      isSelectionMode = selectedSemesters.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          SemestersTableHeader(),
          verticalSpace(8),
          if (isSelectionMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await showDeleteDialog(
                      context: context,
                      content: selectedSemesters.length > 1
                          ? 'semesters'
                          : 'Semester',
                      isSingle: selectedSemesters.length > 1 ? false : true,
                      onConfirm: () {
                        context.read<SemestersCubit>().deleteSemesters(
                          selectedSemesters,
                        );
                        context.read<SemestersCubit>().getAllSemesters();
                      },
                      onCancel: () {},
                    );
                    setState(() {
                      selectedSemesters.clear();
                      isSelectionMode = false;
                    });
                  },
                ),
              ],
            ),
          Expanded(
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
                    itemCount: state.semesters.length,
                    separatorBuilder: (_, _) => verticalSpace(8),
                    itemBuilder: (context, index) {
                      return SemesterRow(
                        index: index,
                        semester: state.semesters[index],
                        isSelected: selectedSemesters.contains(
                          state.semesters[index].name,
                        ),
                        onLongPress: () =>
                            toggleSelection(state.semesters[index].name),
                        onTap: () {
                          if (isSelectionMode) {
                            toggleSelection(state.semesters[index].name);
                          } else {
                            context.pushNamed(
                              AppRoutes.semesterMainScreen,
                              arguments: {
                                'semesterName': state.semesters[index].name,
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
        ],
      ),
    );
  }
}
