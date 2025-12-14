import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_bottom_navigation_bar.dart';
import 'package:student_assistant/features/home/presentation/widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: double.minPositive),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.mainOrange,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Student Assistant',
                    style: AppTextStyles.whiteColor32FontSize,
                  ),
                  verticalSpace(4),
                  Text(
                    'Your academic progress',
                    style: AppTextStyles.lightOrange16FontSize,
                  ),
                ],
              ),
            ),
          ),
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
                          context.pushNamed(AppRoutes.gpaCalculationsScreen);
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
        selectedScreen: HomeBottomNavigationBarEnum.home,
      ),
    );
  }
}
