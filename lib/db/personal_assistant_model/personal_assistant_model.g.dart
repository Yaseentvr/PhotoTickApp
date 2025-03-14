// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_assistant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalAssistantModelAdapter
    extends TypeAdapter<PersonalAssistantModel> {
  @override
  final int typeId = 7;

  @override
  PersonalAssistantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalAssistantModel(
      assId: fields[0] as String,
      assistantPhone: fields[2] as String,
      assistantName: fields[1] as String,
      clientId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalAssistantModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.assId)
      ..writeByte(1)
      ..write(obj.assistantName)
      ..writeByte(2)
      ..write(obj.assistantPhone)
      ..writeByte(3)
      ..write(obj.clientId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalAssistantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
