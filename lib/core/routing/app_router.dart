import 'package:flutter/material.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/home_screen/presentation/widgets/home_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return null;
    }
  }
}
