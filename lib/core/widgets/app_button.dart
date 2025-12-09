import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String desc;
  final VoidCallback onPressed;
  final TextStyle descStyle;
  final Color backgroundColor;
  final Color borderColor;

  const AppButton({
    super.key,
    required this.desc,
    required this.descStyle,
    required this.onPressed,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: borderColor, width: 2),
        ),
        minimumSize: Size(350.w, 60.h),
      ),
      onPressed: onPressed,
      child: Text(desc, style: descStyle, textAlign: TextAlign.center),
    );
  }
}
