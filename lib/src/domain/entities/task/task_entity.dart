import 'package:hive/hive.dart';
import 'package:innoscripta_test_task/src/core/extensions/extensions.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 2)
class TaskEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime? updatedAt;
  @HiveField(5)
  final DateTime? deadline;
  @HiveField(6)
  final StatusEntity statusEntity;
  @HiveField(7)
  final List<TimeEntryEntity> timeEntries;
  @HiveField(8)
  final int? boardId;
  @HiveField(9)
  final DateTime? finishTime;

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
    this.finishTime,
  });

  bool get isFinished => finishTime != null;
  bool get isNotFinished => !isFinished;

  bool get isDeadlinePassed {
    if (deadline == null) return false;
    final now = DateTime.now();
    return deadline!.isBefore(now) && isNotFinished;
  }

  bool get hasActiveTimeEntry {
    return timeEntries.any((element) => element.isActive);
  }

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
    DateTime? finishTime,
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
      finishTime: finishTime ?? this.finishTime,
    );
  }

  TaskEntity clearFinishTime() {
    return TaskEntity(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deadline: deadline,
      statusEntity: statusEntity,
      timeEntries: timeEntries,
      boardId: boardId,
      finishTime: null,
    );
  }

  static List<String> csvColumnNames = const <String>[
    'Name',
    'Description',
    'Create time',
    'Deadline',
    'Finish time',
    'Status',
    'Spent time',
    'Time entries',
  ];
  List<dynamic> toCsv() {
    return [
      name,
      description,
      createdAt,
      deadline,
      finishTime,
      statusEntity.name,
      timeEntries.totalSpentTime.toHoursMinutesSeconds(),
      timeEntries.map((e) => e.readableFormat).toList(),
    ];
  }

  @override
  String toString() {
    return 'TaskEntity(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, deadline: $deadline, statusEntity: $statusEntity, timeEntries: $timeEntries, boardId: $boardId, finishTime: $finishTime)';
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
        boardId.hashCode ^
        finishTime.hashCode;
  }
}
