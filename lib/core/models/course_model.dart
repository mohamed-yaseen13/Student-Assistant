import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/models/section_model.dart';

part 'course_model.g.dart';

@HiveType(typeId: 1)
class CourseModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int index;
  @HiveField(2)
  String searchName;
  @HiveField(3)
  String grade;
  @HiveField(4)
  double credits;
  @HiveField(5)
  bool isRepeated;
  @HiveField(6)
  bool isChanged;
  @HiveField(7)
  String newGrade;
  @HiveField(8)
  Map<String, SectionModel> sections;
  @HiveField(9)
  bool isFailedBefore;

  CourseModel({
    required this.name,
    required this.index,
    required this.searchName,
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
    'index': index,
    'searchName': searchName,
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
      index: json['index'] ?? 0,
      searchName: json['searchName'] as String,
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
    int? index,
    String? searchName,
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
      index: index ?? this.index,
      searchName: searchName ?? this.searchName,
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
