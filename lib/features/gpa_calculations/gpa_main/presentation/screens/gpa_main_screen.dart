import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/add_semester_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/gpa_data_container.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/search_for_course_bar.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semesters_table.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/widgets/gpa_bottom_navigation_bar.dart';

class GpaMainScreen extends StatelessWidget {
  const GpaMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GPA Calculations',
          style: AppTextStyles.whiteColor24FontSize,
        ),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: BlocConsumer<SemestersCubit, SemestersState>(
        listenWhen: (previous, current) => current is SemestersAddSemesterError,
        listener: (context, state) {
          switch (state) {
            case SemestersAddSemesterError _:
              errorState(
                context: context,
                desc: 'Failed To Add Semester',
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
              SearchForCourseBar(),
              verticalSpace(12),
              GpaDataContainer(),
              verticalSpace(12),
              Expanded(child: SemestersTable()),
            ],
          );
        },
      ),
      bottomNavigationBar: GpaBottomNavigationBar(
        selectedScreen: GpaBottomNavigationBarEnum.main,
      ),
      floatingActionButton: AddSemesterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
