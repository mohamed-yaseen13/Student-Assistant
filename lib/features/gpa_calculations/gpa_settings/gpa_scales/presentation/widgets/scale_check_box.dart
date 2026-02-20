import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/cubits/gpa_calculations_cubit.dart';

class ScaleCheckBox extends StatelessWidget {
  final ScaleModel scale;

  const ScaleCheckBox({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: InkWell(
        onTap: () {
          context.read<ScalesCubit>().changeScale(scale.title);
          context.read<GpaCalculationsCubit>().calculateGpaAndCgpa();
        },
        child: Icon(
          scale.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          color: scale.isSelected ? AppColors.mainOrange : Colors.black,
        ),
      ),
    );
  }
}
