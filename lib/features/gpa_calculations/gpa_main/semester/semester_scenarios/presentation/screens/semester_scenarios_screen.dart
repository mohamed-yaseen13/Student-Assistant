import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/widgets/semester_bottom_navigation_bar.dart';

class SemesterScenariosScreen extends StatelessWidget {
  final String semesterName;
  final int semesterIndex;

  const SemesterScenariosScreen({
    super.key,
    required this.semesterName,
    required this.semesterIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$semesterName Scenarios',
          style: AppTextStyles.whiteColor24FontSize,
        ),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: Center(child: Text('$semesterName Scenarios Screen')),
      bottomNavigationBar: SemesterBottomNavigationBar(
        semesterName: semesterName,
        semesterIndex: semesterIndex,
        selectedScreen: SemesterBottomNavigationBarEnum.scenarios,
      ),
    );
  }
}
