import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dependency_injection/di.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:student_assistant/features/auth/presentation/screens/entry_screen.dart';
import 'package:student_assistant/features/auth/presentation/screens/otp_screen.dart';
import 'package:student_assistant/features/home_screen/presentation/screen/home_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );

      case AppRoutes.entryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: EntryScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.otpScreen:
        final args = settings.arguments as Map<String, String?>;
        final email = args['email'];

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: OtpScreen(email: email!),
          ),
          settings: settings,
        );

      default:
        return null;
    }
  }
}
