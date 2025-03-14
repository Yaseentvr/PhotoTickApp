// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientModelAdapter extends TypeAdapter<ClientModel> {
  @override
  final int typeId = 3;

  @override
  ClientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientModel(
      id: fields[0] as String,
      date: fields[1] as String,
      time: fields[2] as String,
      name: fields[3] as String,
      location: fields[4] as String,
      event: fields[5] as String,
      phone: fields[6] as String,
      budget: fields[7] as String,
      personalAssistants: (fields[8] as List?)?.cast<dynamic>(),
      personalEquipments: (fields[9] as List?)?.cast<String>(),
    )..personalExpenses = (fields[10] as List?)?.cast<double>();
  }

  @override
  void write(BinaryWriter writer, ClientModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.event)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.budget)
      ..writeByte(8)
      ..write(obj.personalAssistants)
      ..writeByte(9)
      ..write(obj.personalEquipments)
      ..writeByte(10)
      ..write(obj.personalExpenses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
