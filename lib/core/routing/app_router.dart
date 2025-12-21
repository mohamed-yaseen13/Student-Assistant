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
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_data_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/screens/gpa_main_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/semester_data_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/screens/semester_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_notes/presentation/screens/semester_notes_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_scenarios/presentation/screens/semester_scenarios_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_notes/presentation/screens/gpa_notes_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_scenarios/presentation/screens/gpa_scenarios_screen.dart';
import 'package:student_assistant/features/home/home_settings/presentation/screens/home_settings_screen.dart';
import 'package:student_assistant/features/home/home_main/presentation/screen/home_main_screen.dart';
import 'package:student_assistant/features/home/home_profile/presentation/screens/home_profile_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
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

      // Home
      case AppRoutes.homeProfileScreen:
        return MaterialPageRoute(
          builder: (_) => HomeProfileScreen(),
          settings: settings,
        );
      case AppRoutes.homeMainScreen:
        return MaterialPageRoute(
          builder: (_) => HomeMainScreen(),
          settings: settings,
        );
      case AppRoutes.homeSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => HomeSettingsScreen(),
          settings: settings,
        );

      // GPA Calculations
      case AppRoutes.gpaScenariosScreen:
        return MaterialPageRoute(
          builder: (_) => GpaScenariosScreen(),
          settings: settings,
        );

      case AppRoutes.gpaMainScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SemestersCubit>()..getAllSemesters(),
              ),
              BlocProvider(
                create: (context) => getIt<GpaDataCubit>()..getGpaData(),
              ),
            ],
            child: GpaMainScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.gpaNotesScreen:
        return MaterialPageRoute(
          builder: (_) => GpaNotesScreen(),
          settings: settings,
        );

      // Semester
      case AppRoutes.semesterNotesScreen:
        final args = settings.arguments as Map<String, String?>;
        final semesterName = args['semesterName'];
        return MaterialPageRoute(
          builder: (_) => SemesterNotesScreen(semesterName: semesterName!),
          settings: settings,
        );
      case AppRoutes.semesterMainScreen:
        final args = settings.arguments as Map<String, String?>;
        final semesterName = args['semesterName'];
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<SemesterDataCubit>()
                      ..getSpecificSemesterData(semesterName!),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<CoursesCubit>()..getAllCourses(semesterName!),
              ),
            ],
            child: SemesterScreen(semesterName: semesterName!),
          ),
          settings: settings,
        );
      case AppRoutes.semesterScenariosScreen:
        final args = settings.arguments as Map<String, String?>;
        final semesterName = args['semesterName'];
        return MaterialPageRoute(
          builder: (_) => SemesterScenariosScreen(semesterName: semesterName!),
          settings: settings,
        );

      default:
        return null;
    }
  }
}
