import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/models/scale_model.dart';

class StudentModel {
  String name;
  double cgpa;
  double totalCredits;
  double maxCgpa;
  Map<String, SemesterModel> semesters;
  Map<String, ScaleModel> scales;

  StudentModel({
    required this.name,
    this.cgpa = 0,
    this.semesters = const {},
    this.totalCredits = 0.0,
    this.maxCgpa = 0,
    this.scales = const {},
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'cgpa': cgpa,
    'totalCredits': totalCredits,
    'semesters': semesters.map((k, v) => MapEntry(k, v.toJson())),
    'maxCgpa': maxCgpa,
    'scales': scales.map((k, v) => MapEntry(k, v.toJson())),
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final rawSemesters = json['semesters'];
    final rawScales = json['scales'];

    return StudentModel(
      name: json['name'],
      cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0,
      totalCredits: (json['totalCredits'] as num?)?.toDouble() ?? 0,
      maxCgpa: (json['maxCgpa'] as num?)?.toDouble() ?? 0,
      semesters: rawSemesters is Map
          ? rawSemesters.map(
              (k, v) => MapEntry(
                k,
                SemesterModel.fromJson(Map<String, dynamic>.from(v)),
              ),
            )
          : {},
      scales: rawScales is Map
          ? rawScales.map(
              (k, v) => MapEntry(
                k,
                ScaleModel.fromJson(Map<String, dynamic>.from(v)),
              ),
            )
          : {},
    );
  }

  StudentModel copyWith({
    String? name,
    double? cgpa,
    double? totalCredits,
    double? maxCgpa,
    Map<String, SemesterModel>? semesters,
    Map<String, ScaleModel>? scales,
  }) {
    return StudentModel(
      name: name ?? this.name,
      cgpa: cgpa ?? this.cgpa,
      totalCredits: totalCredits ?? this.totalCredits,
      maxCgpa: maxCgpa ?? this.maxCgpa,
      semesters: semesters ?? Map<String, SemesterModel>.from(this.semesters),
      scales: scales ?? Map<String, ScaleModel>.from(this.scales),
    );
  }
}
