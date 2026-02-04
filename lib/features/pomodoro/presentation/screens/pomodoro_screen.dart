import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro Timer',
          style: AppTextStyles.whiteColor24FontSize,
        ),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.pomodoro),
      body: Center(child: Text('Pomodoro Screen')),
    );
  }
}
