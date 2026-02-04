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

  static Map<String, double> defaultGrades = {
    '--': 0,
    'A+': 4,
    'A': 4,
    'A-': 3.7,
    'B+': 3.3,
    'B': 3,
    'B-': 2.7,
    'C+': 2.3,
    'C': 2,
    'C-': 1.7,
    'D+': 1.3,
    'D': 1,
    'F': 0,
  };
}

enum HomeBottomNavigationBarEnum { profile, main, settings }

enum GpaBottomNavigationBarEnum { scenarios, main, notes }

enum SemesterBottomNavigationBarEnum { scenarios, main, notes }

enum HomeDrawerEnum { main, gpa, pomodoro, calendar, tasks, projects }
