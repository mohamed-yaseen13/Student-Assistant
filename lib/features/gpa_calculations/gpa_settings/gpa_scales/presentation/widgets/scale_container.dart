import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/dot_container.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/expanded_scale_container.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/scale_check_box.dart';

class ScaleContainer extends StatefulWidget {
  final ScaleModel scale;

  const ScaleContainer({super.key, required this.scale});

  @override
  State<ScaleContainer> createState() => _ScaleContainerState();
}

class _ScaleContainerState extends State<ScaleContainer> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, right: 12.w, left: 12.w),
          child: Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.sp),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                children: [
                  horizontalSpace(12),
                  DotContainer(isExpanded: isExpanded),
                  horizontalSpace(12),
                  Text(
                    widget.scale.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  ScaleCheckBox(scale: widget.scale),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded) ExpandedScaleContainer(scale: widget.scale),
      ],
    );
  }
}
