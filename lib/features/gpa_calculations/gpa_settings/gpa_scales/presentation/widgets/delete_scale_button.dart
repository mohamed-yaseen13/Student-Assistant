import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/dialogs/delete_dialog.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';

class DeleteScaleButton extends StatelessWidget {
  final ScaleModel scale;

  const DeleteScaleButton({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
      ),
      child: Text(
        'Delete This Scale',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        await showDeleteDialog(
          context: context,
          onConfirm: () {
            context.read<ScalesCubit>().deleteScale(scale.title);
          },
          onCancel: () {},
          isScale: true,
        );
      },
    );
  }
}
