// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_budget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalBudgetModelAdapter extends TypeAdapter<PersonalBudgetModel> {
  @override
  final int typeId = 5;

  @override
  PersonalBudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalBudgetModel(
      expenseAmount: fields[2] as String,
      expenseId: fields[0] as String,
      expenseName: fields[1] as String,
      expenseDate: fields[4] as DateTime,
      remainingBudget: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalBudgetModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.expenseId)
      ..writeByte(1)
      ..write(obj.expenseName)
      ..writeByte(2)
      ..write(obj.expenseAmount)
      ..writeByte(3)
      ..write(obj.remainingBudget)
      ..writeByte(4)
      ..write(obj.expenseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalBudgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
