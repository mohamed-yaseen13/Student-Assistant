import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/add_or_delete_row_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/grade_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/points_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/range_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/save_scale_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/scale_title_text_form_field.dart';

class CustomScaleForm extends StatefulWidget {
  final ScaleModel? scale;

  const CustomScaleForm({super.key, this.scale});

  @override
  State<CustomScaleForm> createState() => _CustomScaleFormState();
}

class _CustomScaleFormState extends State<CustomScaleForm> {
  String _title = '';
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final List<List<String>> _rows = [
    ['', '', ''],
  ];
  void _addRow() {
    setState(() {
      _rows.add(['', '', '']);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _deleteLastRow() {
    if (_rows.isNotEmpty) {
      setState(() {
        _rows.removeLast();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.scale != null) {
      _title = widget.scale!.title;
      final sortedEntries = widget.scale!.grades.entries.toList()
        ..sort((a, b) {
          final double pointsA = a.value.values.first;
          final double pointsB = b.value.values.first;
          return pointsB.compareTo(pointsA);
        });
      _rows.clear();
      for (final entry in sortedEntries) {
        final String range = entry.key;
        final String grade = entry.value.keys.first;
        final String points = entry.value.values.first.toString();
        _rows.add([grade, range, points]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ScaleTitleTextFormField(
              onChanged: (v) => setState(() {
                _title = v;
              }),
              value: _title,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _rows.length,
                itemBuilder: (context, i) => Row(
                  children: [
                    GradeTextFormField(
                      onChanged: (v) => setState(() => _rows[i][0] = v),
                      value: _rows[i][0],
                    ),
                    RangeTextFormField(
                      value: _rows[i][1],
                      rowIndex: i,
                      rows: _rows,
                      onChanged: (v) => setState(() => _rows[i][1] = v),
                    ),
                    PointsTextFormField(
                      value: _rows[i][2],
                      onChanged: (v) => setState(() => _rows[i][2] = v),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddOrDeleteRowButton(
                  color: Colors.black,
                  label: 'Add',
                  onPressed: _addRow,
                ),
                AddOrDeleteRowButton(
                  color: Colors.red,
                  label: 'Delete',
                  onPressed: _deleteLastRow,
                ),
                SaveScaleButton(
                  oldTitle: widget.scale?.title,
                  title: _title,
                  rows: _rows,
                  formKey: _formKey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
