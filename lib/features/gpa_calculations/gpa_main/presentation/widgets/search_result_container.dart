import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';

class SearchResultContainer extends StatelessWidget {
  const SearchResultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.black,
      color: const Color(0xFFFFF6E7),
      elevation: 4,
      borderRadius: BorderRadius.circular(8.r),
      child: BlocBuilder<SemestersCubit, SemestersState>(
        buildWhen: (previous, current) =>
            current is SemestersSearchForCourseSuccess,
        builder: (context, state) {
          if (state is SemestersSearchForCourseSuccess) {
            return SizedBox(
              height: state.searchedCourseResults.isEmpty
                  ? 0.0
                  : state.searchedCourseResults.length >= 4
                  ? 300.h
                  : state.searchedCourseResults.length * 75.h,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.searchedCourseResults.length,
                separatorBuilder: (_, _) => Divider(height: 1.h),
                itemBuilder: (_, i) => ListTile(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.semesterMainScreen,
                      arguments: {
                        'semesterName':
                            state.searchedCourseResults[i].semesterName,
                        'semesterIndex':
                            state.searchedCourseResults[i].semesterIndex,
                      },
                    );
                  },
                  title: Text(state.searchedCourseResults[i].courseName),
                  subtitle: Text(state.searchedCourseResults[i].semesterName),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
