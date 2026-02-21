import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  final String courseName;

  const CourseScreen({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('$courseName screen !!!!!!!!!!')));
  }
}
