// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScaleModelAdapter extends TypeAdapter<ScaleModel> {
  @override
  final int typeId = 2;

  @override
  ScaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScaleModel(
      title: fields[2] as String,
      grades: (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, double>())),
      isSelected: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScaleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.grades)
      ..writeByte(1)
      ..write(obj.isSelected)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
