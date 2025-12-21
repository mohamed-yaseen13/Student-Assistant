import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/semester_bottom_navigation_bar.dart';

class SemesterNotesScreen extends StatelessWidget {
  final String semesterName;

  const SemesterNotesScreen({super.key, required this.semesterName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('$semesterName Notes Screen')),
      bottomNavigationBar: SemesterBottomNavigationBar(
        semesterName: semesterName,
        selectedScreen: SemesterBottomNavigationBarEnum.notes,
      ),
    );
  }
}
