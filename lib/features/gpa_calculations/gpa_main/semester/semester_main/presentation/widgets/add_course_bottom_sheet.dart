import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_credits_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_grade_dropdown.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/course_name_text_form_field.dart';

class AddCourseBottomSheet extends StatefulWidget {
  const AddCourseBottomSheet({super.key});

  @override
  State<AddCourseBottomSheet> createState() => _AddCourseBottomSheetState();
}

class _AddCourseBottomSheetState extends State<AddCourseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _creditController = TextEditingController();
  String _selectedGrade = '--';

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
              'Add Course',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            verticalSpace(16),
            CourseNameTextFormField(controller: _nameController),
            verticalSpace(16),
            CourseCreditsTextFormField(controller: _creditController),
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
                    'credits': double.parse(_creditController.text),
                    'grade': _selectedGrade,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainOrange,
                foregroundColor: Colors.white,
              ),
              child: Text('Add Course'),
            ),
          ],
        ),
      ),
    );
  }
}
