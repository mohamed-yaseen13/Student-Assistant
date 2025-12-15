import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:student_assistant/core/database/database.dart';
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
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/gpa_main_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/gpa_main_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_main_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Firebase Firestore
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Database
  getIt.registerLazySingleton<Database>(
    () => Database(firestore: getIt<FirebaseFirestore>()),
  );

  // Send Email OPT Service
  getIt.registerLazySingleton<SendEmailOtp>(() => SendEmailOtp());

  // Singup
  getIt.registerLazySingleton<SignupApiService>(
    () => SignupApiService(
      database: getIt<Database>(),
      sendEmailOtp: getIt<SendEmailOtp>(),
    ),
  );
  getIt.registerLazySingleton<SignupRepoImp>(
    () => SignupRepoImp(signupApiService: getIt<SignupApiService>()),
  );
  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(signupRepoImp: getIt<SignupRepoImp>()),
  );

  // OTP
  getIt.registerLazySingleton<OtpApiService>(
    () => OtpApiService(database: getIt<Database>()),
  );
  getIt.registerLazySingleton<OtpRepoImp>(
    () => OtpRepoImp(otpApiService: getIt<OtpApiService>()),
  );
  getIt.registerFactory<OtpCubit>(
    () => OtpCubit(otpRepoImp: getIt<OtpRepoImp>()),
  );

  // Login
  getIt.registerLazySingleton<LoginApiService>(
    () => LoginApiService(
      database: getIt<Database>(),
      sendEmailOtp: getIt<SendEmailOtp>(),
    ),
  );
  getIt.registerLazySingleton<LoginRepoImp>(
    () => LoginRepoImp(loginApiService: getIt<LoginApiService>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginRepoImp: getIt<LoginRepoImp>()),
  );

  // GPA Main
  getIt.registerLazySingleton<GpaMainApiService>(
    () => GpaMainApiService(database: getIt<Database>()),
  );
  getIt.registerLazySingleton<GpaMainRepoImp>(
    () => GpaMainRepoImp(gpaMainApiService: getIt<GpaMainApiService>()),
  );
  getIt.registerFactory<GpaMainCubit>(
    () => GpaMainCubit(gpaMainRepoImp: getIt<GpaMainRepoImp>()),
  );
}
