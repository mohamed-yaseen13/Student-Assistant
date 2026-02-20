// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseModelAdapter extends TypeAdapter<CourseModel> {
  @override
  final int typeId = 1;

  @override
  CourseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseModel(
      name: fields[0] as String,
      index: fields[1] as int,
      searchName: fields[2] as String,
      credits: fields[4] as double,
      grade: fields[3] as String,
      isRepeated: fields[5] as bool,
      isChanged: fields[6] as bool,
      newGrade: fields[7] as String,
      sections: (fields[8] as Map).cast<String, SectionModel>(),
      isFailedBefore: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CourseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.searchName)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(4)
      ..write(obj.credits)
      ..writeByte(5)
      ..write(obj.isRepeated)
      ..writeByte(6)
      ..write(obj.isChanged)
      ..writeByte(7)
      ..write(obj.newGrade)
      ..writeByte(8)
      ..write(obj.sections)
      ..writeByte(9)
      ..write(obj.isFailedBefore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
