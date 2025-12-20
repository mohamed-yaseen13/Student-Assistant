import 'package:student_assistant/features/gpa_calculations/gpa_main/models/section_model.dart';

class CourseModel {
  String name;
  String grade;
  double credits;
  bool isRepeated;
  bool isChanged;
  String newGrade;
  final Map<String, SectionModel> sections;
  bool isFailedBefore;

  CourseModel({
    required this.name,
    required this.credits,
    this.grade = '--',
    this.isRepeated = false,
    this.isChanged = false,
    this.newGrade = '--',
    this.sections = const {},
    this.isFailedBefore = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'grade': grade,
    'credits': credits,
    'isRepeated': isRepeated,
    'isChanged': isChanged,
    'newGrade': newGrade,
    'sections': sections.map((k, v) => MapEntry(k, v.toJson())),
    'isFailedBefore': isFailedBefore,
  };

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final rawSections = json['sections'];

    return CourseModel(
      name: json['name'] as String,
      grade: json['grade'] as String? ?? '--',
      credits: (json['credits'] as num).toDouble(),
      isRepeated: json['isRepeated'] as bool? ?? false,
      isChanged: json['isChanged'] as bool? ?? false,
      newGrade: json['newGrade'] as String? ?? '--',
      isFailedBefore: json['isFailedBefore'] as bool? ?? false,
      sections: rawSections is Map
          ? rawSections.map(
              (k, v) => MapEntry(
                k,
                SectionModel.fromJson(Map<String, dynamic>.from(v)),
              ),
            )
          : {},
    );
  }

  CourseModel copyWith({
    String? name,
    String? grade,
    double? credits,
    bool? isRepeated,
    bool? isChanged,
    String? newGrade,
    Map<String, SectionModel>? sections,
    bool? isFailedBefore,
  }) {
    return CourseModel(
      name: name ?? this.name,
      grade: grade ?? this.grade,
      credits: credits ?? this.credits,
      isRepeated: isRepeated ?? this.isRepeated,
      isChanged: isChanged ?? this.isChanged,
      newGrade: newGrade ?? this.newGrade,
      sections: sections ?? Map<String, SectionModel>.from(this.sections),
      isFailedBefore: isFailedBefore ?? this.isFailedBefore,
    );
  }
}
