import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  final HomeBottomNavigationBarEnum selectedScreen;

  const HomeBottomNavigationBar({super.key, required this.selectedScreen});

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _enumToIndex(HomeBottomNavigationBarEnum screen) {
    return HomeBottomNavigationBarEnum.values.indexOf(screen);
  }

  HomeBottomNavigationBarEnum _indexToEnum(int index) {
    return HomeBottomNavigationBarEnum.values[index];
  }

  String _enumToRoute(HomeBottomNavigationBarEnum screen) {
    switch (screen) {
      case HomeBottomNavigationBarEnum.profile:
        return AppRoutes.profileScreen;
      case HomeBottomNavigationBarEnum.home:
        return AppRoutes.homeScreen;
      case HomeBottomNavigationBarEnum.settings:
        return AppRoutes.homeSettingsScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
