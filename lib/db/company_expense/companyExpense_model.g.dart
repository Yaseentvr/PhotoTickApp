// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companyExpense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyexpenseModelAdapter extends TypeAdapter<CompanyexpenseModel> {
  @override
  final int typeId = 12;

  @override
  CompanyexpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyexpenseModel(
      name: fields[1] as String,
      amount: fields[2] as double,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyexpenseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyexpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
