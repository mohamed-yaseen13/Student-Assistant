import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SemesterBottomNavigationBar extends StatefulWidget {
  final SemesterBottomNavigationBarEnum selectedScreen;

  const SemesterBottomNavigationBar({super.key, required this.selectedScreen});

  @override
  State<SemesterBottomNavigationBar> createState() =>
      _SemesterBottomNavigationBarState();
}

class _SemesterBottomNavigationBarState
    extends State<SemesterBottomNavigationBar> {
  int _enumToIndex(SemesterBottomNavigationBarEnum screen) {
    return SemesterBottomNavigationBarEnum.values.indexOf(screen);
  }

  SemesterBottomNavigationBarEnum _indexToEnum(int index) {
    return SemesterBottomNavigationBarEnum.values[index];
  }

  String _enumToRoute(SemesterBottomNavigationBarEnum screen) {
    switch (screen) {
      case SemesterBottomNavigationBarEnum.notes:
        return AppRoutes.semesterNotesScreen;
      case SemesterBottomNavigationBarEnum.scales:
        return AppRoutes.gpaScalesScreen;
      case SemesterBottomNavigationBarEnum.main:
        return AppRoutes.semesterMainScreen;
      case SemesterBottomNavigationBarEnum.settings:
        return AppRoutes.gpaSettingsScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Main'),
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_increase),
          label: 'Sclaes',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: _enumToIndex(widget.selectedScreen),
      onTap: (index) {
        final selected = _indexToEnum(index);

        if (selected != widget.selectedScreen) {
          context.pushNamed(_enumToRoute(selected));
        }
      },
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      backgroundColor: AppColors.lightOrange,
    );
  }
}
