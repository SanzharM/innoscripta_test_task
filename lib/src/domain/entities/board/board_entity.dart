import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';

class BoardEntity {
  final int id;
  final String name;
  final List<StatusEntity> statuses;
  final List<TaskEntity> tasks;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BoardEntity({
    required this.id,
    required this.name,
    this.statuses = StatusEntity.defaultValues,
    this.tasks = const [],
    required this.createdAt,
    this.updatedAt,
  });

  BoardEntity copyWith({
    int? id,
    String? name,
    List<StatusEntity>? statuses,
    List<TaskEntity>? tasks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BoardEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      statuses: statuses ?? this.statuses,
      tasks: tasks ?? this.tasks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoardEntity && other.id == id;
    // && other.name == name &&
    // listEquals(other.statuses, statuses) &&
    // listEquals(other.tasks, tasks) &&
    // other.createdAt == createdAt &&
    // other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ statuses.hashCode ^ tasks.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'BoardEntity(id: $id, name: $name, statuses: $statuses, tasks: $tasks, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
