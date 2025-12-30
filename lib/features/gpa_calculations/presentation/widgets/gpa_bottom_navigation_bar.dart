import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class GpaBottomNavigationBar extends StatefulWidget {
  final GpaBottomNavigationBarEnum selectedScreen;

  const GpaBottomNavigationBar({super.key, required this.selectedScreen});

  @override
  State<GpaBottomNavigationBar> createState() => _GpaBottomNavigationBarState();
}

class _GpaBottomNavigationBarState extends State<GpaBottomNavigationBar> {
  int _enumToIndex(GpaBottomNavigationBarEnum screen) {
    return GpaBottomNavigationBarEnum.values.indexOf(screen);
  }

  GpaBottomNavigationBarEnum _indexToEnum(int index) {
    return GpaBottomNavigationBarEnum.values[index];
  }

  String _enumToRoute(GpaBottomNavigationBarEnum screen) {
    switch (screen) {
      case GpaBottomNavigationBarEnum.notes:
        return AppRoutes.gpaNotesScreen;

      case GpaBottomNavigationBarEnum.main:
        return AppRoutes.gpaMainScreen;
      case GpaBottomNavigationBarEnum.scenarios:
        return AppRoutes.gpaScenariosScreen;
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
