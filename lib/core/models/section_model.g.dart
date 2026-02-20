// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionModelAdapter extends TypeAdapter<SectionModel> {
  @override
  final int typeId = 0;

  @override
  SectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionModel(
      name: fields[0] as String,
      index: fields[1] as int,
      obtainedMark: fields[2] as double,
      fullMark: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SectionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.obtainedMark)
      ..writeByte(3)
      ..write(obj.fullMark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
