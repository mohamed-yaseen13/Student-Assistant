import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';

class AddCustomScaleButton extends StatelessWidget {
  const AddCustomScaleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
      ),
      onPressed: () {
        final scalesCubit = context.read<ScalesCubit>();
        context.pushNamed(
          AppRoutes.gpaCustomScaleScreen,
          arguments: {'scalesCubit': scalesCubit},
        );
      },
      child: Text(
        'Add Custom Scale',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
