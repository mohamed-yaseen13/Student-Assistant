import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_credits_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_grade_dropdown.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_name_text_form_field.dart';

class EditCourseBottomSheet extends StatefulWidget {
  final String initialCourseName;
  final String initialCourseGrade;
  final double initialCourseCredits;

  const EditCourseBottomSheet({
    super.key,
    required this.initialCourseName,
    required this.initialCourseGrade,
    required this.initialCourseCredits,
  });

  @override
  State<EditCourseBottomSheet> createState() => _EditCourseBottomSheetState();
}

class _EditCourseBottomSheetState extends State<EditCourseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _creditsController = TextEditingController();
  String _selectedGrade = '--';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialCourseName;
    _creditsController.text = widget.initialCourseCredits.toString();
    _selectedGrade = widget.initialCourseGrade;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Course',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            verticalSpace(16),
            CourseNameTextFormField(controller: _nameController),
            verticalSpace(16),
            CourseCreditsTextFormField(controller: _creditsController),
            verticalSpace(16),
            CourseGradeDropdown(
              initialGrade: _selectedGrade,
              onChanged: (value) {
                setState(() {
                  _selectedGrade = value!;
                });
              },
            ),
            verticalSpace(24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.pop({
                    'name': _nameController.text,
                    'credits': double.parse(_creditsController.text),
                    'grade': _selectedGrade,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainOrange,
                foregroundColor: Colors.white,
              ),
              child: Text('Edit Course'),
            ),
          ],
        ),
      ),
    );
  }
}
