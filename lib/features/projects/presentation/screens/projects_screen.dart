import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Projects',
          style: AppTextStyles.whiteColor24FontSize,
        ),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.projects),
      body: Center(child: Text('Projects Screen')),
    );
  }
}
