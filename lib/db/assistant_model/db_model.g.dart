// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssistantModelAdapter extends TypeAdapter<AssistantModel> {
  @override
  final int typeId = 1;

  @override
  AssistantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssistantModel(
      name: fields[1] as String,
      Phone: fields[2] as String,
      Place: fields[3] as String,
      id: fields[0] as String,
      selectedroles: (fields[4] as List).cast<RoleModel>(),
      equipment: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AssistantModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.Phone)
      ..writeByte(3)
      ..write(obj.Place)
      ..writeByte(4)
      ..write(obj.selectedroles)
      ..writeByte(5)
      ..write(obj.equipment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssistantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
