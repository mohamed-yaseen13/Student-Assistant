import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/app_controller.dart';
import 'package:student_assistant/core/bloc/app_bloc_observer.dart';
import 'package:student_assistant/core/dependency_injection/di.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/firebase_options.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  await SharedPrefs.init();
  runApp(const AppController());
}
