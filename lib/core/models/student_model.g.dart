// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 4;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      name: fields[0] as String,
      cgpa: fields[1] as double,
      semesters: (fields[4] as Map).cast<String, SemesterModel>(),
      totalCredits: fields[2] as double,
      maxCgpa: fields[3] as double,
      scales: (fields[5] as Map).cast<String, ScaleModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cgpa)
      ..writeByte(2)
      ..write(obj.totalCredits)
      ..writeByte(3)
      ..write(obj.maxCgpa)
      ..writeByte(4)
      ..write(obj.semesters)
      ..writeByte(5)
      ..write(obj.scales);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
