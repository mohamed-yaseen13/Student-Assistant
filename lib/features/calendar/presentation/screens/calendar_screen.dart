import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar', style: AppTextStyles.whiteColor24FontSize),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.calendar),
      body: Center(child: Text('Calendar Screen')),
    );
  }
}
