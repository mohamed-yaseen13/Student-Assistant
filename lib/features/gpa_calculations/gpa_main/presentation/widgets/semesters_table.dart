import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_main_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_main_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semester_row.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semesters_table_header.dart';

class SemestersTable extends StatelessWidget {
  const SemestersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          SemestersTableHeader(),
          verticalSpace(8),
          Expanded(
            child: BlocBuilder<GpaMainCubit, GpaMainState>(
              builder: (context, state) {
                if (state is GpaMainGetAllSemestersLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GpaMainGetAllSemestersSuccess) {
                  return ListView.separated(
                    itemCount: state.semesters.length,
                    separatorBuilder: (_, _) => verticalSpace(8),
                    itemBuilder: (context, index) {
                      return SemesterRow(
                        index: index,
                        semester: state.semesters[index],
                      );
                    },
                  );
                }
                if (state is GpaMainError) {
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
