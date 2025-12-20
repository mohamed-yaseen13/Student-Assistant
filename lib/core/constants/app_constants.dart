import 'package:student_assistant/features/home/home_main/presentation/widgets/feature_card.dart';

class AppConstants {
  static List<FeatureItem> features = [
    FeatureItem(
      title: 'GPA Calculations',
      description: 'Track and calculate your cumulative GPA',
      iconPath: 'assets/icons/calculate.svg',
    ),
    FeatureItem(
      title: 'Pomodoro Timer',
      description: 'Focus with timed study sessions',
      iconPath: 'assets/icons/pomodoro.svg',
    ),
    FeatureItem(
      title: 'Calendar',
      description: 'Manage your schedule and deadlines',
      iconPath: 'assets/icons/calendar.svg',
    ),
    FeatureItem(
      title: 'Individual Tasks',
      description: 'Organize your personal assignments',
      iconPath: 'assets/icons/tasks.svg',
    ),
    FeatureItem(
      title: 'Group Projects',
      description: 'Collaborate with your team members',
      iconPath: 'assets/icons/groups.svg',
    ),
  ];

  static List<String> defaultGrades = [
    '--',
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D+',
    'D',
    'F',
  ];
}

enum HomeBottomNavigationBarEnum { profile, main, settings }

enum GpaBottomNavigationBarEnum { notes, scales, main, scenarios, settings }

enum SemesterBottomNavigationBarEnum { main, notes, scales, settings }
