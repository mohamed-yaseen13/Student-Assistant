import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';

class SemesterModel {
  String name;
  double gpa;
  List<CourseModel> courses;
  double cgpaOriginal;
  double cgpaChanged;
  double attemptedCredits;
  double earnedCredits;
  String note;

  SemesterModel({
    required this.name,
    this.courses = const [],
    this.gpa = 0,
    this.cgpaOriginal = 0,
    this.cgpaChanged = 0,
    this.attemptedCredits = 0,
    this.earnedCredits = 0,
    this.note = '',
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'gpa': gpa,
    'courses': courses.map((c) => c.toJson()).toList(),
    'cgpaOriginal': cgpaOriginal,
    'cgpaChanged': cgpaChanged,
    'attemptedCredits': attemptedCredits,
    'earnedCredits': earnedCredits,
    'note': note,
  };

  factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
    name: json['name'] as String,
    gpa: (json['gpa'] as num?)?.toDouble() ?? 0.0,
    courses:
        (json['courses'] as List<dynamic>?)
            ?.map((c) => CourseModel.fromJson(c as Map<String, dynamic>))
            .toList() ??
        [],
    cgpaOriginal: (json['cgpaOriginal'] as num?)?.toDouble() ?? 0.0,
    cgpaChanged: (json['cgpaChanged'] as num?)?.toDouble() ?? 0.0,
    attemptedCredits: (json['attemptedCredits'] as num?)?.toDouble() ?? 0.0,
    earnedCredits: (json['earnedCredits'] as num?)?.toDouble() ?? 0.0,
    note: json['note'] as String? ?? '',
  );

  SemesterModel copyWith({
    String? name,
    double? gpa,
    List<CourseModel>? courses,
    double? cgpaOriginal,
    double? cgpaChanged,
    double? attemptedCredits,
    double? earnedCredits,
    String? note,
  }) {
    return SemesterModel(
      name: name ?? this.name,
      gpa: gpa ?? this.gpa,
      courses: courses ?? List<CourseModel>.from(this.courses),
      cgpaOriginal: cgpaOriginal ?? this.cgpaOriginal,
      cgpaChanged: cgpaChanged ?? this.cgpaChanged,
      attemptedCredits: attemptedCredits ?? this.attemptedCredits,
      earnedCredits: earnedCredits ?? this.earnedCredits,
      note: note ?? this.note,
    );
  }
}
