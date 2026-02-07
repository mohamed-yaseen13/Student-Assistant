import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PointsTextFormField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const PointsTextFormField({
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
          decoration: const InputDecoration(hintText: 'Points'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please add points';
            }
            if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
              return 'Numbers only';
            }
            return null;
          },
        ),
      ),
    );
  }
}
