import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/core/models/student_model.dart';
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

  static ScaleModel defaultScale = ScaleModel(
    isSelected: true,
    title: 'Faculty of Engineering Scale',
    grades: {
      '97-100': {'A+': 4.0},
      '93-97': {'A': 4.0},
      '89-93': {'A-': 3.7},
      '84-89': {'B+': 3.3},
      '80-84': {'B': 3.0},
      '76-80': {'B-': 2.7},
      '73-76': {'C+': 2.3},
      '70-73': {'C': 2.0},
      '67-70': {'C-': 1.7},
      '64-67': {'D+': 1.3},
      '60-64': {'D': 1.0},
      '00-60': {'F': 0.0},
      '00-00': {'Fr': 0.0},
    },
  );

  static const String studentBox = 'studentBox';

  static Box<StudentModel> box = Hive.box<StudentModel>(studentBox);
}

enum HomeBottomNavigationBarEnum { profile, main, settings }

enum GpaBottomNavigationBarEnum { scenarios, main, settings }

enum SemesterBottomNavigationBarEnum { scenarios, main, notes }

enum HomeDrawerEnum { main, gpa, pomodoro, calendar, tasks, projects }
