import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SemesterBottomNavigationBar extends StatefulWidget {
  final String semesterName;
  final int semesterIndex;
  final SemesterBottomNavigationBarEnum selectedScreen;

  const SemesterBottomNavigationBar({
    super.key,
    required this.selectedScreen,
    required this.semesterName,
    required this.semesterIndex,
  });

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
      case SemesterBottomNavigationBarEnum.scenarios:
        return AppRoutes.semesterScenariosScreen;
      case SemesterBottomNavigationBarEnum.main:
        return AppRoutes.semesterMainScreen;
      case SemesterBottomNavigationBarEnum.notes:
        return AppRoutes.semesterNotesScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_awesome_motion_rounded),
          label: 'Scenarios',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Main'),
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
      ],
      currentIndex: _enumToIndex(widget.selectedScreen),
      onTap: (index) {
        final selected = _indexToEnum(index);

        if (selected != widget.selectedScreen) {
          context.pushNamed(
            _enumToRoute(selected),
            arguments: {
              'semesterName': widget.semesterName,
              'semesterIndex': widget.semesterIndex,
            },
          );
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
