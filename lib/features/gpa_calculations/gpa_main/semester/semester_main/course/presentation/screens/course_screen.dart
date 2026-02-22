import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/cubit/sections_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/cubit/sections_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/widgets/add_section_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/widgets/course_date_container.dart';

class CourseScreen extends StatelessWidget {
  final String courseName;
  final String semesterName;

  const CourseScreen({
    super.key,
    required this.courseName,
    required this.semesterName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName, style: AppTextStyles.whiteColor24FontSize),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: BlocConsumer<SectionsCubit, SectionsState>(
        listenWhen: (previous, current) => current is SectionsAddSectionError,
        listener: (context, state) {
          switch (state) {
            case SectionsAddSectionError _:
              errorState(
                context: context,
                desc: 'Failed to add section',
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
              verticalSpace(8),
              CourseDateContainer(
                semesterName: semesterName,
                courseName: courseName,
              ),
              // sections table
            ],
          );
        },
      ),
      floatingActionButton: AddSectionButton(
        courseName: courseName,
        semesterName: semesterName,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
