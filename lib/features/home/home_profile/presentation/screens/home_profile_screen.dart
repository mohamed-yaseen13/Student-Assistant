import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/features/home/widgets/home_bottom_navigation_bar.dart';

class HomeProfileScreen extends StatelessWidget {
  const HomeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(child: Text('Profile Screen')),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedScreen: HomeBottomNavigationBarEnum.profile,
      ),
    );
  }
}
