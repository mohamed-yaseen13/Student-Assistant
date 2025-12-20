import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/widgets/data_container.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/specific_semester_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/specific_semester_state.dart';

class SemesterDataContainer extends StatelessWidget {
  const SemesterDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      leftColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attempted Credits : ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Earned Credits : ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('GPA', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Max GPA you can get', style: TextStyle(fontSize: 16.sp)),
        ],
      ),
      rightColumn: BlocBuilder<SpecificSemesterCubit, SpecificSemesterState>(
        buildWhen: (previous, current) =>
            current is SpecificSemesterLoading ||
            current is SpecificSemesterSuccess ||
            current is SpecificSemesterError,
        builder: (context, state) {
          if (state is SpecificSemesterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SpecificSemesterSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.semesterDataModel.attemptedCredits}',
                  style: TextStyle(fontSize: 18.sp),
                ),
                verticalSpace(12),
                Text(
                  '${state.semesterDataModel.earnedCredits}',
                  style: TextStyle(fontSize: 18.sp, color: Colors.green),
                ),
                verticalSpace(12),
                Text(
                  state.semesterDataModel.gpa.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18.sp),
                ),
                verticalSpace(12),
                Text(
                  state.semesterDataModel.maxGpa.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            );
          }
          if (state is SpecificSemesterError) {
            return Center(
              child: Text(
                state.apiErrorModel.message ?? 'Failed to get your GPA Data',
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
