import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';
import 'package:student_assistant/features/auth/data/apis/auth_api_service.dart';
import 'package:student_assistant/features/auth/data/repos/auth_repo_imp.dart';
import 'package:student_assistant/features/auth/presentation/cubit/auth_cubit.dart';

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

  // Auth
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(
      database: getIt<Database>(),
      sendEmailOtp: getIt<SendEmailOtp>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepoImp>(
    () => AuthRepoImp(authApiService: getIt<AuthApiService>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepoImp: getIt<AuthRepoImp>()),
  );
}
