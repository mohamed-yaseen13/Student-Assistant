import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_assistant/app_controller.dart';
import 'package:student_assistant/core/dependency_injection/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupGetIt();
  runApp(const AppController());
}
