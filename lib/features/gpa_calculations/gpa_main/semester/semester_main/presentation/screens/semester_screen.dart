import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/add_course_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/courses_table.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/semester_bottom_navigation_bar.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/semester_data_container.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/cubits/gpa_calculations_cubit.dart';

class SemesterScreen extends StatelessWidget {
  final String semesterName;
  final int semesterIndex;

  const SemesterScreen({
    super.key,
    required this.semesterName,
    required this.semesterIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(semesterName, style: AppTextStyles.whiteColor24FontSize),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: BlocListener<CoursesCubit, CoursesState>(
        listener: (context, state) {
          if (state is CoursesEditCourseSuccess) {
            context.read<GpaCalculationsCubit>().calculateGpaAndCgpa();
          }
        },
        child: BlocConsumer<CoursesCubit, CoursesState>(
          listenWhen: (previous, current) =>
              current is CoursesAddCourseSuccess ||
              current is CoursesAddCourseError,
          listener: (context, state) {
            switch (state) {
              case CoursesAddCourseSuccess _:
                context.read<GpaCalculationsCubit>().calculateGpaAndCgpa();
              case CoursesAddCourseError _:
                errorState(
                  context: context,
                  desc: 'Failed To Add Course',
                  message: state.apiErrorModel.message,
                );
              default:
                null;
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12),
                SemesterDataContainer(semesterName: semesterName),
                verticalSpace(12),
                Expanded(
                  child: CoursesTable(
                    semesterName: semesterName,
                    semesterIndex: semesterIndex,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SemesterBottomNavigationBar(
        semesterIndex: semesterIndex,
        selectedScreen: SemesterBottomNavigationBarEnum.main,
        semesterName: semesterName,
      ),
      floatingActionButton: AddCourseButton(
        semesterName: semesterName,
        semesterIndex: semesterIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
