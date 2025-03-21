// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_ model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginmodelAdapter extends TypeAdapter<Loginmodel> {
  @override
  final int typeId = 2;

  @override
  Loginmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Loginmodel(
      loginName: fields[1] as String,
      loginPhone: fields[2] as String,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Loginmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.loginName)
      ..writeByte(2)
      ..write(obj.loginPhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
