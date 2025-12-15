import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemestersTableHeader extends StatelessWidget {
  const SemestersTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '#',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            'Semesters',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            'GPA',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            'CGPA',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }
}
