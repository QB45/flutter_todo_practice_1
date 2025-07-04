// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskHiveAdapter extends TypeAdapter<TaskHive> {
  @override
  final int typeId = 0;

  @override
  TaskHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskHive()
      ..name = fields[1] as String
      ..date = fields[2] as DateTime
      ..highPriority = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, TaskHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.highPriority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
