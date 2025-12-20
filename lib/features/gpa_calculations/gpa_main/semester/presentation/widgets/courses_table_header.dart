import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesTableHeader extends StatelessWidget {
  const CoursesTableHeader({super.key});

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
            'Courses',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            'Grades',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            'Credits',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }
}
