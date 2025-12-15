import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataContainer extends StatelessWidget {
  final Widget leftColumn;
  final Widget rightColumn;

  const DataContainer({
    super.key,
    required this.leftColumn,
    required this.rightColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 8.h, left: 12.w, right: 12.w),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [leftColumn, const Spacer(), rightColumn],
          ),
        ),
      ),
    );
  }
}
