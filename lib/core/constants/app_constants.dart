import 'package:flutter/material.dart';
import 'package:student_assistant/features/home/presentation/widgets/feature_card.dart';

class AppConstants {
  static final List<FeatureItem> features = [
    FeatureItem(
      id: 1,
      title: 'GPA Calculations',
      description: 'Track and calculate your cumulative GPA',
      icon: Icons.calculate,
      color: Colors.blue,
    ),
    FeatureItem(
      id: 2,
      title: 'Pomodoro Timer',
      description: 'Focus with timed study sessions',
      icon: Icons.timer,
      color: Colors.red,
    ),
    FeatureItem(
      id: 3,
      title: 'Calendar',
      description: 'Manage your schedule and deadlines',
      icon: Icons.calendar_today,
      color: Colors.green,
    ),
    FeatureItem(
      id: 4,
      title: 'Individual Tasks',
      description: 'Organize your personal assignments',
      icon: Icons.check_box,
      color: Colors.purple,
    ),
    FeatureItem(
      id: 5,
      title: 'Group Projects',
      description: 'Collaborate with your team members',
      icon: Icons.groups,
      color: Colors.orange,
    ),
  ];
}

enum HomeBottomNavigationBarEnum { profile, home, settings }
