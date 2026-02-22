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
import 'package:student_assistant/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/screens/gpa_main_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/cubit/sections_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/screens/course_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/screens/semester_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_notes/presentation/screens/semester_notes_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_scenarios/presentation/screens/semester_scenarios_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_scenarios/presentation/screens/gpa_scenarios_screen.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/screens/custom_scale_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/screens/scales_screen.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/presentation/screens/gpa_settings_screen.dart';
import 'package:student_assistant/features/home/home_settings/presentation/screens/home_settings_screen.dart';
import 'package:student_assistant/features/home/home_main/presentation/screen/home_main_screen.dart';
import 'package:student_assistant/features/home/home_profile/presentation/screens/home_profile_screen.dart';
import 'package:student_assistant/features/pomodoro/presentation/screens/pomodoro_screen.dart';
import 'package:student_assistant/features/projects/presentation/screens/projects_screen.dart';
import 'package:student_assistant/features/tasks/presentation/screens/tasks_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      // Signup
      case AppRoutes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: SignupScreen(),
          ),
          settings: settings,
        );
      // OTP
      case AppRoutes.otpScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final email = args['email'] as String;
        final isLoggingIn = args['isLoggingIn'] as bool?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<OtpCubit>(),
            child: OtpScreen(email: email, isLoggingIn: isLoggingIn),
          ),
          settings: settings,
        );
      // Login
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
      // GPA Scenarios
      case AppRoutes.gpaScenariosScreen:
        return MaterialPageRoute(
          builder: (_) => GpaScenariosScreen(),
          settings: settings,
        );
      // GPA Main
      case AppRoutes.gpaMainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SemestersCubit>(),
            child: GpaMainScreen(),
          ),
          settings: settings,
        );
      // Semester
      // Semester Notes
      case AppRoutes.semesterNotesScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final semesterName = args['semesterName'] as String;
        final semesterIndex = args['semesterIndex'] as int;
        return MaterialPageRoute(
          builder: (_) => SemesterNotesScreen(
            semesterName: semesterName,
            semesterIndex: semesterIndex,
          ),
          settings: settings,
        );
      // Semester Main
      case AppRoutes.semesterMainScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final semesterName = args['semesterName'] as String;
        final semesterIndex = args['semesterIndex'] as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CoursesCubit>(),
            child: SemesterScreen(
              semesterName: semesterName,
              semesterIndex: semesterIndex,
            ),
          ),
          settings: settings,
        );
      // Course
      case AppRoutes.courseScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final courseName = args['courseName'] as String;
        final semesterName = args['semesterName'] as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SectionsCubit>(),
            child: CourseScreen(
              courseName: courseName,
              semesterName: semesterName,
            ),
          ),
          settings: settings,
        );
      // Semester Scenarios
      case AppRoutes.semesterScenariosScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final semesterName = args['semesterName'];
        final semesterIndex = args['semesterIndex'] as int;
        return MaterialPageRoute(
          builder: (_) => SemesterScenariosScreen(
            semesterName: semesterName!,
            semesterIndex: semesterIndex,
          ),
          settings: settings,
        );
      // GPA Settings
      case AppRoutes.gpaSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => GpaSettingsScreen(),
          settings: settings,
        );
      // GPA Sclaes
      case AppRoutes.gpaScalesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ScalesCubit>(),
            child: ScalesScreen(),
          ),
          settings: settings,
        );
      // GPA Custom Scale
      case AppRoutes.gpaCustomScaleScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final scalesCubit = args['scalesCubit'] as ScalesCubit;
        final ScaleModel? scale = args['scale'];
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: scalesCubit,
            child: CustomScaleScreen(scale: scale),
          ),
          settings: settings,
        );

      // pomodoro
      case AppRoutes.pomodoroTimerScreen:
        return MaterialPageRoute(
          builder: (_) => PomodoroScreen(),
          settings: settings,
        );

      // routes inside pomodoro feature

      // calendar
      case AppRoutes.calendarScreen:
        return MaterialPageRoute(
          builder: (_) => CalendarScreen(),
          settings: settings,
        );
      // routes inside calendar feature

      // tasks
      case AppRoutes.tasksScreen:
        return MaterialPageRoute(
          builder: (_) => TasksScreen(),
          settings: settings,
        );
      // routes inside tasks feature

      // projects
      case AppRoutes.projectsScreen:
        return MaterialPageRoute(
          builder: (_) => ProjectsScreen(),
          settings: settings,
        );
      // routes inside projects feature

      default:
        return null;
    }
  }
}
