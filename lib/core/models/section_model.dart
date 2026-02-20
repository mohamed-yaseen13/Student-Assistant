import 'package:hive_flutter/hive_flutter.dart';

part 'section_model.g.dart';

@HiveType(typeId: 0)
class SectionModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int index;
  @HiveField(2)
  double obtainedMark;
  @HiveField(3)
  int fullMark;

  SectionModel({
    required this.name,
    required this.index,
    this.obtainedMark = 0,
    this.fullMark = 0,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'index': index,
    'obtainedMark': obtainedMark,
    'fullMark': fullMark,
  };

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    name: json['name'] as String,
    index: json['index'] ?? 0,
    obtainedMark: (json['obtainedMark'] as double?) ?? 0,
    fullMark: (json['fullMark'] as int?) ?? 0,
  );

  SectionModel copyWith({
    String? name,
    int? index,
    double? obtainedMark,
    int? fullMark,
  }) {
    return SectionModel(
      name: name ?? this.name,
      index: index ?? this.index,
      obtainedMark: obtainedMark ?? this.obtainedMark,
      fullMark: fullMark ?? this.fullMark,
    );
  }
}
