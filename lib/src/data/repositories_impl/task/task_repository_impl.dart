import 'package:innoscripta_test_task/src/data/datasources/task/task_data_source.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this.dataSource);

  final TaskDataSource dataSource;

  @override
  Future<TaskEntity> createTask({required String name, int? boardId, StatusEntity? status}) {
    return dataSource.createTask(name: name, boardId: boardId, status: status);
  }

  @override
  Future<bool> deleteTask(TaskEntity taskEntity) {
    return dataSource.deleteTask(taskEntity);
  }

  @override
  Future<bool> editTask(TaskEntity taskEntity) {
    return dataSource.editTask(taskEntity);
  }

  @override
  Future<TaskEntity> getTask(int id) {
    return dataSource.getTask(id);
  }

  @override
  Future<List<TaskEntity>> getTasks({int? boardId}) {
    return dataSource.getTasks(boardId: boardId);
  }
}
