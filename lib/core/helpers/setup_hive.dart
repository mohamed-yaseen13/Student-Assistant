import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/models/course_model.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/core/models/section_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';
import 'package:student_assistant/core/models/student_model.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SectionModelAdapter());
  Hive.registerAdapter(CourseModelAdapter());
  Hive.registerAdapter(SemesterModelAdapter());
  Hive.registerAdapter(ScaleModelAdapter());
  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>(AppConstants.studentBox);
}
