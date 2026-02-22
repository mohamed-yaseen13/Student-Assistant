import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/widgets/section_full_mark_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/widgets/section_got_mark_text_form_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/widgets/section_name_text_form_field.dart';

class AddSectionBottomSheet extends StatefulWidget {
  const AddSectionBottomSheet({super.key});

  @override
  State<AddSectionBottomSheet> createState() => _AddSectionBottomSheetState();
}

class _AddSectionBottomSheetState extends State<AddSectionBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gotMarkController = TextEditingController();
  final _fullMarkController = TextEditingController();

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
              'Add Section',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            verticalSpace(16),
            SectionNameTextFormField(controller: _nameController),
            verticalSpace(16),
            SectionGotMarkTextFormField(controller: _gotMarkController),
            verticalSpace(16),
            SectionFullMarkTextFormField(controller: _fullMarkController),
            verticalSpace(24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.pop({
                    'sectionName': _nameController.text,
                    'got': double.parse(_gotMarkController.text),
                    'from': int.parse(_fullMarkController.text),
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainOrange,
                foregroundColor: Colors.white,
              ),
              child: Text('Add Section'),
            ),
          ],
        ),
      ),
    );
  }
}
