// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemesterModelAdapter extends TypeAdapter<SemesterModel> {
  @override
  final int typeId = 3;

  @override
  SemesterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemesterModel(
      name: fields[0] as String,
      index: fields[1] as int,
      courses: (fields[4] as Map).cast<String, CourseModel>(),
      gpa: fields[2] as double,
      maxGpa: fields[3] as double,
      cgpaOriginal: fields[5] as double,
      cgpaChanged: fields[6] as double,
      attemptedCredits: fields[7] as double,
      earnedCredits: fields[8] as double,
      note: fields[9] as String,
      repeatedCourses: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SemesterModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.gpa)
      ..writeByte(3)
      ..write(obj.maxGpa)
      ..writeByte(4)
      ..write(obj.courses)
      ..writeByte(5)
      ..write(obj.cgpaOriginal)
      ..writeByte(6)
      ..write(obj.cgpaChanged)
      ..writeByte(7)
      ..write(obj.attemptedCredits)
      ..writeByte(8)
      ..write(obj.earnedCredits)
      ..writeByte(9)
      ..write(obj.note)
      ..writeByte(10)
      ..write(obj.repeatedCourses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
