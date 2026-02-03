import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/widgets/delete_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_row.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/courses_table_header.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/cubits/gpa_calculations_cubit.dart';

class CoursesTable extends StatefulWidget {
  final String semesterName;
  final int semesterIndex;

  const CoursesTable({
    super.key,
    required this.semesterName,
    required this.semesterIndex,
  });

  @override
  State<CoursesTable> createState() => _CoursesTableState();
}

class _CoursesTableState extends State<CoursesTable> {
  List<CourseModel> selectedCourses = [];
  bool isSelectionMode = false;

  void toggleSelection(CourseModel course) {
    setState(() {
      selectedCourses.removeWhere((c) => c.name == course.name);
      if (!selectedCourses.any((c) => c.name == course.name)) {
        selectedCourses.add(course);
      }
      isSelectionMode = selectedCourses.isNotEmpty;
    });
  }

  Future<void> deleteSelectedCourses() async {
    final coursesCubit = context.read<CoursesCubit>();
    await showDeleteDialog(
      context: context,
      content: selectedCourses.length > 1 ? 'courses' : 'Course',
      isSingle: selectedCourses.length > 1 ? false : true,
      onConfirm: () async {
        await coursesCubit.deleteCourses(
          widget.semesterName,
          selectedCourses,
          widget.semesterIndex,
        );
      },
      onCancel: () {
        setState(() {
          selectedCourses.clear();
          isSelectionMode = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            CoursesTableHeader(),
            verticalSpace(8),
            Expanded(
              child: BlocListener<CoursesCubit, CoursesState>(
                listenWhen: (previous, current) =>
                    current is CoursesDeleteCoursesSuccess,
                listener: (context, state) {
                  if (state is CoursesDeleteCoursesSuccess) {
                    context.read<GpaCalculationsCubit>().calculateGpaAndCgpa();
                    setState(() {
                      selectedCourses.clear();
                      isSelectionMode = false;
                    });
                  }
                },
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
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: state.courses.length,
                        separatorBuilder: (_, _) => verticalSpace(8),
                        itemBuilder: (context, index) {
                          final course = state.courses[index];
                          return CourseRow(
                            index: index,
                            semesterIndex: widget.semesterIndex,
                            course: state.courses[index],
                            semesterName: widget.semesterName,
                            isSelected: selectedCourses.any(
                              (c) => c.name == course.name,
                            ),
                            onLongPress: () => toggleSelection(course),
                            onTap: () {
                              if (isSelectionMode) {
                                toggleSelection(course);
                              }
                              // else {
                              // final gpaCubit = context
                              //      .read<GpaCalculationsCubit>();
                              // context.pushNamed(
                              //  AppRoutes.sectionMainScreen,
                              //  arguments: {
                              //    'gpaCubit': gpaCubit,
                              //    ''
                              //  }
                              // )
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
            ),
          ],
        ),
      ),
      floatingActionButton: isSelectionMode
          ? DeleteButton(onPressed: deleteSelectedCourses)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
