import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/widgets/data_container.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_data_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_data_state.dart';

class GpaDataContainer extends StatelessWidget {
  const GpaDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DataContainer(
      leftColumn: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cumulative GPA: ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Total Credits: ', style: TextStyle(fontSize: 18.sp)),
          verticalSpace(12),
          Text('Max CGPA you can get: ', style: TextStyle(fontSize: 18.sp)),
        ],
      ),
      rightColumn: BlocBuilder<GpaDataCubit, GpaDataState>(
        builder: (context, state) {
          if (state is GpaDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GpaDataSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.gpaDataModel.cgpa}',
                  style: TextStyle(fontSize: 18.sp),
                ),
                verticalSpace(12),
                Text(
                  '${state.gpaDataModel.totalCredits}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.mainOrange,
                  ),
                ),
                verticalSpace(12),
                Text(
                  '2.76',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.mainOrange,
                  ),
                ),
              ],
            );
          }
          if (state is GpaDataError) {
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
