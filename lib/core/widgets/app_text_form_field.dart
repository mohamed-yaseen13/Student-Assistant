import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final TextInputType? textInputType;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.placeholder,
    this.prefixIcon,
    this.validator,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        prefixIcon: prefixIcon,
        hintText: placeholder,
        hintStyle: AppTextStyles.grayColor16FontSizeRegular,
      ),
      validator: validator,
      keyboardType: textInputType,
    );
  }
}
