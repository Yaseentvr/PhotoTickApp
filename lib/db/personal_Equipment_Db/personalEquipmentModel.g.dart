// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalEquipmentModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalequipmentmodelAdapter
    extends TypeAdapter<Personalequipmentmodel> {
  @override
  final int typeId = 9;

  @override
  Personalequipmentmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Personalequipmentmodel(
      equipment: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Personalequipmentmodel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.equipment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalequipmentmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
