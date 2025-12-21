import 'package:flutter/material.dart';
//import 'package:student_assistant/core/constants/app_constants.dart';
//import 'package:student_assistant/features/gpa_calculations/widgets/gpa_bottom_navigation_bar.dart';

class GpaScalesScreen extends StatelessWidget {
  const GpaScalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(child: Text('data')),
      //bottomNavigationBar: GpaBottomNavigationBar(
      //  selectedScreen: GpaBottomNavigationBarEnum.scales,
      //),
    );
  }
}
