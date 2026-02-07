import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/presentation/widgets/scales_row.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/widgets/gpa_bottom_navigation_bar.dart';

class GpaSettingsScreen extends StatelessWidget {
  const GpaSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Settings', style: AppTextStyles.whiteColor24FontSize),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: Padding(
        padding: EdgeInsets.only(top: 16.h, left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScalesRow(),
            const Divider(color: Colors.grey, thickness: 1, height: 0),
            // Failed Before Row
          ],
        ),
      ),
      bottomNavigationBar: GpaBottomNavigationBar(
        selectedScreen: GpaBottomNavigationBarEnum.settings,
      ),
    );
  }
}
