import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/widgets/app_bar_title.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/add_semester_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/gpa_data_container.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/search_input_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semesters_table.dart';
import 'package:student_assistant/features/gpa_calculations/widgets/gpa_bottom_navigation_bar.dart';

class GpaMainScreen extends StatelessWidget {
  const GpaMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: double.minPositive,
      ),
      body: BlocConsumer<SemestersCubit, SemestersState>(
        listener: (context, state) {
          switch (state) {
            case SemestersAddSemesterLoading _:
              loadingState(context: context);
            case SemestersAddSemesterSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              context.read<SemestersCubit>().getAllSemesters();
            case SemestersError _:
              Navigator.of(context, rootNavigator: true).pop();
              errorState(
                context: context,
                desc: 'Failed To Add Semester',
                message: state.apiErrorModel.message!,
              );
            default:
              null;
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarTitle(title: 'GPA Calculation'),
              verticalSpace(8),
              SearchInputField(),
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
    );
  }
}
