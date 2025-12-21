import 'package:get_it/get_it.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';
import 'package:student_assistant/features/auth/login/data/apis/login_api_service.dart';
import 'package:student_assistant/features/auth/login/data/repos/login_repo_imp.dart';
import 'package:student_assistant/features/auth/login/presentation/cubits/login_cubit.dart';
import 'package:student_assistant/features/auth/otp/data/apis/otp_api_service.dart';
import 'package:student_assistant/features/auth/otp/data/repos/otp_repo_imp.dart';
import 'package:student_assistant/features/auth/otp/presentation/cubits/otp_cubit.dart';
import 'package:student_assistant/features/auth/signup/data/apis/signup_api_service.dart';
import 'package:student_assistant/features/auth/signup/data/repos/signup_repo_imp.dart';
import 'package:student_assistant/features/auth/signup/presentation/cubits/signup_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/gpa_data_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/semesters_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/gpa_data_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/semesters_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_data_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/apis/courses_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/apis/semester_data_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/repos/courses_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/repos/semester_data_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/semester_data_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Send Email OPT Service
  getIt.registerLazySingleton<SendEmailOtp>(() => SendEmailOtp());

  // Singup
  getIt.registerLazySingleton<SignupApiService>(
    () => SignupApiService(sendEmailOtp: getIt<SendEmailOtp>()),
  );
  getIt.registerLazySingleton<SignupRepoImp>(
    () => SignupRepoImp(signupApiService: getIt<SignupApiService>()),
  );
  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(signupRepoImp: getIt<SignupRepoImp>()),
  );

  // OTP
  getIt.registerLazySingleton<OtpApiService>(() => OtpApiService());
  getIt.registerLazySingleton<OtpRepoImp>(
    () => OtpRepoImp(otpApiService: getIt<OtpApiService>()),
  );
  getIt.registerFactory<OtpCubit>(
    () => OtpCubit(otpRepoImp: getIt<OtpRepoImp>()),
  );

  // Login
  getIt.registerLazySingleton<LoginApiService>(
    () => LoginApiService(sendEmailOtp: getIt<SendEmailOtp>()),
  );
  getIt.registerLazySingleton<LoginRepoImp>(
    () => LoginRepoImp(loginApiService: getIt<LoginApiService>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginRepoImp: getIt<LoginRepoImp>()),
  );

  // GPA Data
  getIt.registerLazySingleton<GpaDataApiService>(() => GpaDataApiService());
  getIt.registerLazySingleton<GpaDataRepoImp>(
    () => GpaDataRepoImp(gpaDataApiService: getIt<GpaDataApiService>()),
  );
  getIt.registerFactory<GpaDataCubit>(
    () => GpaDataCubit(gpaDataRepoImp: getIt<GpaDataRepoImp>()),
  );

  // Semesters
  getIt.registerLazySingleton<SemestersApiService>(() => SemestersApiService());
  getIt.registerLazySingleton<SemestersRepoImp>(
    () => SemestersRepoImp(semestersApiService: getIt<SemestersApiService>()),
  );
  getIt.registerFactory<SemestersCubit>(
    () => SemestersCubit(semestersRepoImp: getIt<SemestersRepoImp>()),
  );

  // Semester Data
  getIt.registerLazySingleton<SemesterDataApiService>(
    () => SemesterDataApiService(),
  );
  getIt.registerLazySingleton<SemesterDataRepoImp>(
    () => SemesterDataRepoImp(
      semesterDataApiService: getIt<SemesterDataApiService>(),
    ),
  );
  getIt.registerFactory<SemesterDataCubit>(
    () => SemesterDataCubit(semesterDataRepoImp: getIt<SemesterDataRepoImp>()),
  );

  // Courses
  getIt.registerLazySingleton<CoursesApiService>(() => CoursesApiService());
  getIt.registerLazySingleton<CoursesRepoImp>(
    () => CoursesRepoImp(coursesApiService: getIt<CoursesApiService>()),
  );
  getIt.registerFactory<CoursesCubit>(
    () => CoursesCubit(coursesRepoImp: getIt<CoursesRepoImp>()),
  );
}
