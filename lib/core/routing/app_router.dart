import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/dependency_injection/di.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/features/auth/login/presentation/cubits/login_cubit.dart';
import 'package:student_assistant/features/auth/login/presentation/screens/login_screen.dart';
import 'package:student_assistant/features/auth/otp/presentation/cubits/otp_cubit.dart';
import 'package:student_assistant/features/auth/otp/presentation/screens/otp_screen.dart';
import 'package:student_assistant/features/auth/signup/presentation/cubits/signup_cubit.dart';
import 'package:student_assistant/features/auth/signup/presentation/screens/signup_screen.dart';
import 'package:student_assistant/features/home_screen/presentation/screen/home_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );

      case AppRoutes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: SignupScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.otpScreen:
        final args = settings.arguments as Map<String, String?>;
        final email = args['email'];

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OtpCubit>(),
            child: OtpScreen(email: email!),
          ),
          settings: settings,
        );

      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
          settings: settings,
        );

      default:
        return null;
    }
  }
}
