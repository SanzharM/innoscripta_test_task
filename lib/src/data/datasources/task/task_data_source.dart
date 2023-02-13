import 'package:hive_flutter/adapters.dart';
import 'package:innoscripta_test_task/src/core/exceptions/exceptions.dart';
import 'package:innoscripta_test_task/src/core/storage/hive_storage.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';

abstract class TaskDataSource {
  Future<List<TaskEntity>> getTasks({int? boardId});

  Future<TaskEntity> getTask(int id);

  Future<TaskEntity> createTask({required String name, int? boardId, StatusEntity? status});

  Future<bool> editTask(TaskEntity taskEntity);

  Future<bool> deleteTask(TaskEntity taskEntity);
}

class TaskDataSourceImpl implements TaskDataSource {
  Box<TaskEntity> get box => Hive.box(HiveStorage.taskBox);

  int _getLastId() => box.values.isEmpty ? 0 : box.values.last.id;

  @override
  Future<TaskEntity> createTask({
    required String name,
    int? boardId,
    StatusEntity? status,
  }) async {
    final entity = TaskEntity(
      id: _getLastId() + 1,
      name: name,
      statusEntity: status ?? StatusEntity.todo,
      createdAt: DateTime.now(),
      boardId: boardId,
    );

    box.add(entity);
    return entity;
  }

  @override
  Future<bool> deleteTask(TaskEntity taskEntity) async {
    for (int i = 0; i < box.values.length; i++) {
      var task = box.values.elementAt(i);
      if (task == taskEntity) {
        box.deleteAt(i);
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> editTask(TaskEntity taskEntity) async {
    int index = box.values.toList().indexOf(taskEntity);
    if (index <= -1) {
      return false;
    }

    box.deleteAt(index);
    box.add(taskEntity.copyWith(updatedAt: DateTime.now()));
    return true;
  }

  @override
  Future<TaskEntity> getTask(int id) async {
    for (var task in box.values) {
      if (task.id == id) {
        return task;
      }
    }
    throw const TaskNotFoundException(message: 'Task not found.');
  }

  @override
  Future<List<TaskEntity>> getTasks({int? boardId}) async {
    if (boardId == null) {
      return box.values.toList();
    }

    final result = <TaskEntity>[];
    for (var task in box.values) {
      if (task.boardId == boardId) {
        result.add(task);
      }
    }
    result.sort((a, b) {
      return (a.updatedAt ?? a.createdAt).compareTo(b.updatedAt ?? b.createdAt);
    });

    return result;
  }
}
