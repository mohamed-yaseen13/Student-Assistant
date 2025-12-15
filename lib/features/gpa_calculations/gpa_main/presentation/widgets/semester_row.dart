import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SemesterRow extends StatelessWidget {
  const SemesterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.sp),
        color: AppColors.lightOrange,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '1',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              'Term 1',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              '3.54',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              '3.54',
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 2, child: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
