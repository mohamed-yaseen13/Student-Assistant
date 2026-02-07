import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotContainer extends StatelessWidget {
  final bool isExpanded;

  const DotContainer({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
        color: isExpanded ? Colors.black : Colors.white,
      ),
    );
  }
}
