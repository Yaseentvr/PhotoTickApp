// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_screen _model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class imagescreenModelAdapter extends TypeAdapter<imagescreen_Model> {
  @override
  final int typeId = 10;

  @override
  imagescreen_Model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return imagescreen_Model(
      imagePath: fields[1] as String,
      imageId: fields[0] as String,
      place: fields[2] as String,
      description: fields[3] as String,
      date1: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, imagescreen_Model obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageId)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.place)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date1);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is imagescreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
