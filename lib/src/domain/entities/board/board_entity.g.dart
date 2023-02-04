// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoardEntityAdapter extends TypeAdapter<BoardEntity> {
  @override
  final int typeId = 3;

  @override
  BoardEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoardEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      statuses: (fields[2] as List).cast<StatusEntity>(),
      tasks: (fields[3] as List).cast<TaskEntity>(),
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BoardEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.statuses)
      ..writeByte(3)
      ..write(obj.tasks)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
