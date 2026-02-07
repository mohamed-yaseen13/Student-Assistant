import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';

class EditScaleButton extends StatelessWidget {
  final ScaleModel scale;

  const EditScaleButton({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.green),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      child: Text(
        'Edit This Scale',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        final scalesCubit = context.read<ScalesCubit>();
        context.pushNamed(
          AppRoutes.gpaCustomScaleScreen,
          arguments: {'scalesCubit': scalesCubit, 'scale': scale},
        );
      },
    );
  }
}
