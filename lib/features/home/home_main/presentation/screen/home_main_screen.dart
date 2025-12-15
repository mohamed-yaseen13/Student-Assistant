import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/widgets/app_bar_title.dart';
import 'package:student_assistant/features/home/widgets/home_bottom_navigation_bar.dart';
import 'package:student_assistant/features/home/home_main/presentation/widgets/feature_card.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: double.minPositive,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarTitle(title: 'Student Assistant'),
          verticalSpace(12),
          Expanded(
            child: ListView.builder(
              itemCount: AppConstants.features.length,
              itemBuilder: (context, index) {
                final feature = AppConstants.features[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: FeatureCard(
                    feature: feature,
                    onTap: () {
                      switch (index) {
                        case 0:
                          context.pushNamed(AppRoutes.gpaMainScreen);
                        case 1:
                          context.pushNamed(AppRoutes.pomodoroTimerScreen);
                        case 2:
                          context.pushNamed(AppRoutes.calendarScreen);
                        case 3:
                          context.pushNamed(AppRoutes.tasksScreen);
                        case 4:
                          context.pushNamed(AppRoutes.projectsScreen);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedScreen: HomeBottomNavigationBarEnum.main,
      ),
    );
  }
}
