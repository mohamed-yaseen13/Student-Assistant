import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/semester_bottom_navigation_bar.dart';

class SemesterNotesScreen extends StatelessWidget {
  final String semesterName;
  final int semesterIndex;

  const SemesterNotesScreen({
    super.key,
    required this.semesterName,
    required this.semesterIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('$semesterName Notes Screen')),
      bottomNavigationBar: SemesterBottomNavigationBar(
        semesterName: semesterName,
        semesterIndex: semesterIndex,
        selectedScreen: SemesterBottomNavigationBarEnum.notes,
      ),
    );
  }
}
