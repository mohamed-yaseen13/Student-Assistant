import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrDeleteRowButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const AddOrDeleteRowButton({
    super.key,
    required this.color,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: color),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
