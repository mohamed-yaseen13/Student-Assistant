import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/courses_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/widgets/course_row.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/widgets/courses_table_header.dart';

class CoursesTable extends StatefulWidget {
  final String semesterName;

  const CoursesTable({super.key, required this.semesterName});

  @override
  State<CoursesTable> createState() => _CoursesTableState();
}

class _CoursesTableState extends State<CoursesTable> {
  List<String> selectedCourses = [];
  bool isSelectionMode = false;

  void toggleSelection(String courseName) {
    setState(() {
      if (selectedCourses.contains(courseName)) {
        selectedCourses.remove(courseName);
      } else {
        selectedCourses.add(courseName);
      }
      isSelectionMode = selectedCourses.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          CoursesTableHeader(),
          verticalSpace(8),
          if (isSelectionMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDeleteDialog(
                      context: context,
                      content: selectedCourses.length > 1
                          ? 'courses'
                          : 'Course',
                      isSingle: selectedCourses.length > 1 ? false : true,
                      onConfirm: () {
                        context.read<CoursesCubit>().deleteCourses(
                          widget.semesterName,
                          selectedCourses,
                        );
                        context.read<CoursesCubit>().getAllCourses(
                          widget.semesterName,
                        );
                      },
                      onCancel: () {},
                    );
                    setState(() {
                      selectedCourses.clear();
                      isSelectionMode = false;
                    });
                  },
                ),
              ],
            ),
          Expanded(
            child: BlocBuilder<CoursesCubit, CoursesState>(
              buildWhen: (previous, current) =>
                  current is CoursesGetAllCoursesLoading ||
                  current is CoursesGetAllCoursesSuccess ||
                  current is CoursesGetAllCoursesError,
              builder: (context, state) {
                if (state is CoursesGetAllCoursesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CoursesGetAllCoursesSuccess) {
                  return ListView.separated(
                    itemCount: state.courses.length,
                    separatorBuilder: (_, _) => verticalSpace(8),
                    itemBuilder: (context, index) {
                      return CourseRow(
                        index: index,
                        course: state.courses[index],
                        semesterName: widget.semesterName,
                        isSelected: selectedCourses.contains(
                          state.courses[index].name,
                        ),
                        onLongPress: () =>
                            toggleSelection(state.courses[index].name),
                        onTap: () {
                          if (isSelectionMode) {
                            toggleSelection(state.courses[index].name);
                          }
                          // else {
                          // context.pushNamed(AppRoutes.sectionMainScreen,)
                          //}
                        },
                      );
                    },
                  );
                }
                if (state is CoursesGetAllCoursesError) {
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
