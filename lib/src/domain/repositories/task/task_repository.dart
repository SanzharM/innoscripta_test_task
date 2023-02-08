import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasksFromBoard(int boardId);

  Future<TaskEntity> getTask(int id);

  Future<TaskEntity> createTask({required String name, int? boardId, StatusEntity? status});

  Future<bool> editTask(TaskEntity taskEntity);

  Future<bool> deleteTask(TaskEntity taskEntity);
}
