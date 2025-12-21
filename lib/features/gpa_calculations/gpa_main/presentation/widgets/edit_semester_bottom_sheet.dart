import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/semester_name_text_form_field.dart';

class EditSemesterBottomSheet extends StatefulWidget {
  final String initialName;

  const EditSemesterBottomSheet({super.key, required this.initialName});

  @override
  State<EditSemesterBottomSheet> createState() =>
      _EditSemesterBottomSheetState();
}

class _EditSemesterBottomSheetState extends State<EditSemesterBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
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
              'Edit Semester',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            verticalSpace(16),
            SemesterNameTextFormField(controller: _nameController),
            verticalSpace(24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.pop({'newSemesterName': _nameController.text});
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainOrange,
                foregroundColor: Colors.white,
              ),
              child: Text('Edit Semester'),
            ),
          ],
        ),
      ),
    );
  }
}
