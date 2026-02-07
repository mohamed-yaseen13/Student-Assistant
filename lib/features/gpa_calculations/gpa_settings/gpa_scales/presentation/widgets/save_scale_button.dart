import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';

class SaveScaleButton extends StatelessWidget {
  final String? oldTitle;
  final String title;
  final List<List<String>> rows;
  final GlobalKey<FormState> formKey;

  const SaveScaleButton({
    super.key,
    required this.rows,
    required this.title,
    required this.formKey,
    this.oldTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.green),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context.read<ScalesCubit>().saveScale(
              title: title,
              rows: rows,
              oldTitle: oldTitle,
            );
          }
        },
        child: Text(
          'Save',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
