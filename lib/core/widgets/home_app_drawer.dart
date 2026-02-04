import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/widgets/drawer_tile.dart';

class HomeAppDrawer extends StatelessWidget {
  final HomeDrawerEnum selectedRoute;

  const HomeAppDrawer({super.key, required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color(0xFFFFF6E7),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(24),
              DrawerTile(
                icon: Icon(
                  Icons.dashboard_rounded,
                  color: selectedRoute == HomeDrawerEnum.main
                      ? Colors.orange
                      : Colors.grey[700],
                ),
                label: 'Main Dashboard',
                selected: selectedRoute == HomeDrawerEnum.main,
                onTap: () => context.pushNamed(AppRoutes.homeMainScreen),
              ),
              verticalSpace(12),
              DrawerTile(
                icon: SvgPicture.asset(
                  'assets/icons/calculate.svg',
                  colorFilter: ColorFilter.mode(
                    selectedRoute == HomeDrawerEnum.gpa
                        ? Colors.orange
                        : Colors.grey[700]!,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'GPA Calculations',
                selected: selectedRoute == HomeDrawerEnum.gpa,
                onTap: () => context.pushNamed(AppRoutes.gpaMainScreen),
              ),
              verticalSpace(12),
              DrawerTile(
                icon: SvgPicture.asset(
                  'assets/icons/pomodoro.svg',
                  colorFilter: ColorFilter.mode(
                    selectedRoute == HomeDrawerEnum.pomodoro
                        ? Colors.orange
                        : Colors.grey[700]!,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Pomodoro Timer',
                selected: selectedRoute == HomeDrawerEnum.pomodoro,
                onTap: () => context.pushNamed(AppRoutes.pomodoroTimerScreen),
              ),
              verticalSpace(12),
              DrawerTile(
                icon: Icon(
                  Icons.calendar_today,
                  color: selectedRoute == HomeDrawerEnum.calendar
                      ? Colors.orange
                      : Colors.grey[700],
                ),
                label: 'Calendar',
                selected: selectedRoute == HomeDrawerEnum.calendar,
                onTap: () => context.pushNamed(AppRoutes.calendarScreen),
              ),
              verticalSpace(12),
              DrawerTile(
                icon: SvgPicture.asset(
                  'assets/icons/tasks.svg',
                  colorFilter: ColorFilter.mode(
                    selectedRoute == HomeDrawerEnum.tasks
                        ? Colors.orange
                        : Colors.grey[700]!,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Individual Tasks',
                selected: selectedRoute == HomeDrawerEnum.tasks,
                onTap: () => context.pushNamed(AppRoutes.tasksScreen),
              ),
              verticalSpace(12),
              DrawerTile(
                icon: SvgPicture.asset(
                  'assets/icons/groups.svg',
                  colorFilter: ColorFilter.mode(
                    selectedRoute == HomeDrawerEnum.projects
                        ? Colors.orange
                        : Colors.grey[700]!,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Group Projects',
                selected: selectedRoute == HomeDrawerEnum.projects,
                onTap: () => context.pushNamed(AppRoutes.projectsScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
