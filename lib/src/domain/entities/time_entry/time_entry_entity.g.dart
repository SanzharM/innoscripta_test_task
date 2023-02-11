// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entry_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeEntryEntityAdapter extends TypeAdapter<TimeEntryEntity> {
  @override
  final int typeId = 0;

  @override
  TimeEntryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeEntryEntity(
      startTime: fields[0] as DateTime,
      endTime: fields[1] as DateTime?,
      description: fields[2] as String?,
      taskId: fields[3] as int?,
      isGlobal: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TimeEntryEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.taskId)
      ..writeByte(4)
      ..write(obj.isGlobal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeEntryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
