import 'package:student_assistant/features/gpa_calculations/gpa_main/models/section_model.dart';

class CourseModel {
  String name;
  String grade;
  double credits;
  bool isRepeated;
  bool isChanged;
  String newGrade;
  List<SectionModel> sections;
  bool isFailedBefore;

  CourseModel({
    required this.name,
    required this.credits,
    this.grade = '--',
    this.isRepeated = false,
    this.isChanged = false,
    this.newGrade = '--',
    this.sections = const [],
    this.isFailedBefore = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'grade': grade,
    'credits': credits,
    'isRepeated': isRepeated,
    'isChanged': isChanged,
    'newGrade': newGrade,
    'sections': sections.map((s) => s.toJson()).toList(),
    'isFailedBefore': isFailedBefore,
  };

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    name: json['name'] as String,
    grade: json['grade'] as String,
    credits: (json['credits'] as num).toDouble(),
    isRepeated: json['isRepeated'] as bool,
    isChanged: json['isChanged'] as bool,
    newGrade: json['newGrade'] as String,
    sections: (json['sections'] as List)
        .map((s) => SectionModel.fromJson(s as Map<String, dynamic>))
        .toList(),
    isFailedBefore: json['isFailedBefore'] as bool,
  );

  CourseModel copyWith({
    String? name,
    String? grade,
    double? credits,
    bool? isRepeated,
    bool? isChanged,
    String? newGrade,
    List<SectionModel>? sections,
    bool? isFailedBefore,
  }) {
    return CourseModel(
      name: name ?? this.name,
      grade: grade ?? this.grade,
      credits: credits ?? this.credits,
      isRepeated: isRepeated ?? this.isRepeated,
      isChanged: isChanged ?? this.isChanged,
      newGrade: newGrade ?? this.newGrade,
      sections: sections ?? List<SectionModel>.from(this.sections),
      isFailedBefore: isFailedBefore ?? this.isFailedBefore,
    );
  }
}
