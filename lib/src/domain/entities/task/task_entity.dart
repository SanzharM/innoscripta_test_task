import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

class TaskEntity {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deadline;
  final StatusEntity statusEntity;
  final List<TimeEntryEntity> timeEntries;
  final int? boardId;

  const TaskEntity({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.updatedAt,
    this.deadline,
    this.statusEntity = StatusEntity.todo,
    this.timeEntries = const [],
    this.boardId,
  });

  TaskEntity copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deadline,
    StatusEntity? statusEntity,
    List<TimeEntryEntity>? timeEntries,
    int? boardId,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deadline: deadline ?? this.deadline,
      statusEntity: statusEntity ?? this.statusEntity,
      timeEntries: timeEntries ?? this.timeEntries,
      boardId: boardId ?? this.boardId,
    );
  }

  @override
  String toString() {
    return 'TaskEntity(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, deadline: $deadline, statusEntity: $statusEntity, timeEntries: $timeEntries, boardId: $boardId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskEntity && other.id == id;
    // && other.name == name &&
    // other.description == description &&
    // other.createdAt == createdAt &&
    // other.updatedAt == updatedAt &&
    // other.statusEntity == statusEntity &&
    // listEquals(other.timeEntries, timeEntries) &&
    // other.boardId == boardId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deadline.hashCode ^
        statusEntity.hashCode ^
        timeEntries.hashCode ^
        boardId.hashCode;
  }
}
