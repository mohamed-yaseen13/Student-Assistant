import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Individual Tasks',
          style: AppTextStyles.whiteColor24FontSize,
        ),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.tasks),
      body: Center(child: Text('tasks Screen')),
    );
  }
}
