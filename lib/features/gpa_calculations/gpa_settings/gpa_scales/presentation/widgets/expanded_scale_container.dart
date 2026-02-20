import 'package:flutter/material.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/delete_scale_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/edit_scale_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/scale_table.dart';

class ExpandedScaleContainer extends StatelessWidget {
  final ScaleModel scale;

  const ExpandedScaleContainer({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTable(scale: scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EditScaleButton(scale: scale),
            if (!scale.isSelected) DeleteScaleButton(scale: scale),
          ],
        ),
      ],
    );
  }
}
