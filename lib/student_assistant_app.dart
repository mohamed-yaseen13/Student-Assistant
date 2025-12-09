import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/routing/app_router.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class StudentAssistantApp extends StatelessWidget {
  const StudentAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.mainOrange,
              titleTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.entryScreen,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
