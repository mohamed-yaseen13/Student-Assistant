import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/dependency_injection/di.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/core/routing/app_router.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/cubits/gpa_calculations_cubit.dart';

class StudentAssistantApp extends StatelessWidget {
  const StudentAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = SharedPrefs.getIsUserLoggedIn();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => getIt<GpaCalculationsCubit>(),
          child: MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.backgroundColor,
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.mainOrange,
                titleTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: isUserLoggedIn
                ? AppRoutes.homeMainScreen
                : AppRoutes.signupScreen,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      },
    );
  }
}
