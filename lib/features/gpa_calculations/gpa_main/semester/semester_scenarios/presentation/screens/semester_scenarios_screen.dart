import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/widgets/semester_bottom_navigation_bar.dart';

class SemesterScenariosScreen extends StatelessWidget {
  final String semesterName;

  const SemesterScenariosScreen({super.key, required this.semesterName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('$semesterName Scenarios Screen')),
      bottomNavigationBar: SemesterBottomNavigationBar(
        semesterName: semesterName,
        selectedScreen: SemesterBottomNavigationBarEnum.scenarios,
      ),
    );
  }
}
