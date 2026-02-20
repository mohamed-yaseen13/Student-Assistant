import 'package:hive_flutter/hive_flutter.dart';

part 'scale_model.g.dart';

@HiveType(typeId: 2)
class ScaleModel extends HiveObject {
  @HiveField(0)
  Map<String, Map<String, double>> grades;
  @HiveField(1)
  bool isSelected;
  @HiveField(2)
  String title;

  ScaleModel({
    required this.title,
    required this.grades,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "isSelected": isSelected,
    "grades": grades,
  };

  factory ScaleModel.fromJson(Map<String, dynamic> json) {
    return ScaleModel(
      title: json["title"] as String,
      isSelected: json["isSelected"] ?? false,
      grades: (json["grades"] as Map).map(
        (range, value) => MapEntry(range, Map<String, double>.from(value)),
      ),
    );
  }

  ScaleModel copyWith({
    String? title,
    Map<String, Map<String, double>>? grades,
    bool? isSelected,
  }) {
    return ScaleModel(
      title: title ?? this.title,
      grades: grades ?? Map.from(this.grades),
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
