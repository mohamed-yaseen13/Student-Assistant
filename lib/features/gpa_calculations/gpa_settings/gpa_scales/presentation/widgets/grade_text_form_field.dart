import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeTextFormField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const GradeTextFormField({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.sp),
        child: TextFormField(
          initialValue: value,
          maxLength: 2,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\+\-]')),
            LengthLimitingTextInputFormatter(2),
          ],
          decoration: const InputDecoration(hintText: 'Grade', counterText: ''),
          onChanged: onChanged,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return 'Please Enter a Grade';
            }
            if (!RegExp(r'^[A-Za-z\+\-]{1,2}$').hasMatch(v)) {
              return 'Only letters and (+/- allowed)';
            }
            return null;
          },
        ),
      ),
    );
  }
}
