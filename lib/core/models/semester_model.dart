import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/models/course_model.dart';

part 'semester_model.g.dart';

@HiveType(typeId: 3)
class SemesterModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int index;
  @HiveField(2)
  double gpa;
  @HiveField(3)
  double maxGpa;
  @HiveField(4)
  Map<String, CourseModel> courses;
  @HiveField(5)
  double cgpaOriginal;
  @HiveField(6)
  double cgpaChanged;
  @HiveField(7)
  double attemptedCredits;
  @HiveField(8)
  double earnedCredits;
  @HiveField(9)
  String note;
  @HiveField(10)
  int repeatedCourses;

  SemesterModel({
    required this.name,
    required this.index,
    this.courses = const {},
    this.gpa = 0.0,
    this.maxGpa = 0.0,
    this.cgpaOriginal = 0.0,
    this.cgpaChanged = 0.0,
    this.attemptedCredits = 0.0,
    this.earnedCredits = 0.0,
    this.note = '',
    this.repeatedCourses = 0,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'index': index,
    'gpa': gpa,
    'maxGpa': maxGpa,
    'courses': courses.map((k, v) => MapEntry(k, v.toJson())),
    'cgpaOriginal': cgpaOriginal,
    'cgpaChanged': cgpaChanged,
    'attemptedCredits': attemptedCredits,
    'earnedCredits': earnedCredits,
    'note': note,
    'repeatedCourses': repeatedCourses,
  };

  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    final rawCourses = json['courses'];

    return SemesterModel(
      name: json['name'] as String,
      index: json['index'] ?? 0,
      gpa: (json['gpa'] as num?)?.toDouble() ?? 0,
      maxGpa: (json['maxGpa'] as num?)?.toDouble() ?? 0,
      cgpaOriginal: (json['cgpaOriginal'] as num?)?.toDouble() ?? 0,
      cgpaChanged: (json['cgpaChanged'] as num?)?.toDouble() ?? 0,
      attemptedCredits: (json['attemptedCredits'] as num?)?.toDouble() ?? 0,
      earnedCredits: (json['earnedCredits'] as num?)?.toDouble() ?? 0,
      note: json['note'] as String? ?? '',
      courses: rawCourses is Map
          ? rawCourses.map(
              (k, v) => MapEntry(
                k,
                CourseModel.fromJson(Map<String, dynamic>.from(v)),
              ),
            )
          : {},
      repeatedCourses: json['repeatedCourses'] ?? 0,
    );
  }

  SemesterModel copyWith({
    String? name,
    int? index,
    double? gpa,
    double? maxGpa,
    Map<String, CourseModel>? courses,
    double? cgpaOriginal,
    double? cgpaChanged,
    double? attemptedCredits,
    double? earnedCredits,
    String? note,
    int? repeatedCourses,
  }) {
    return SemesterModel(
      name: name ?? this.name,
      index: index ?? this.index,
      gpa: gpa ?? this.gpa,
      maxGpa: maxGpa ?? this.maxGpa,
      courses: courses ?? Map<String, CourseModel>.from(this.courses),
      cgpaOriginal: cgpaOriginal ?? this.cgpaOriginal,
      cgpaChanged: cgpaChanged ?? this.cgpaChanged,
      attemptedCredits: attemptedCredits ?? this.attemptedCredits,
      earnedCredits: earnedCredits ?? this.earnedCredits,
      note: note ?? this.note,
      repeatedCourses: repeatedCourses ?? this.repeatedCourses,
    );
  }
}
