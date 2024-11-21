// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalModelAdapter extends TypeAdapter<GoalModel> {
  @override
  final int typeId = 4;

  @override
  GoalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      goalAmount: fields[2] as int,
      savingModel: (fields[3] as List).cast<SavingModel>(),
      endingDate: fields[4] as DateTime,
      color: fields[7] as int?,
      imagePath: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GoalModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.goalAmount)
      ..writeByte(3)
      ..write(obj.savingModel)
      ..writeByte(4)
      ..write(obj.endingDate)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SavingModelAdapter extends TypeAdapter<SavingModel> {
  @override
  final int typeId = 5;

  @override
  SavingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingModel(
      savingAmount: fields[0] as int,
      createdDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SavingModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.savingAmount)
      ..writeByte(1)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
