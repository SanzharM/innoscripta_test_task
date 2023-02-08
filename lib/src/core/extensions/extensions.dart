import 'package:innoscripta_test_task/src/core/exceptions/exceptions.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';

extension XPaginationList<T> on List<T> {
  List<T> pagination(int page, {int perPage = 10}) {
    if (page <= 0) {
      throw const PaginationException();
    }

    if ((length / perPage) >= page - 1) {
      int rangeStart = perPage * (page - 1);
      int rangeEnd = perPage * page;
      if (rangeEnd > length) {
        rangeEnd = length;
      }
      return getRange(rangeStart, rangeEnd).toList();
    }
    return [];
  }
}

extension XSortedTaskList on List<TaskEntity> {
  List<TaskEntity> sortByStatus(StatusEntity status) {
    List<TaskEntity> result = [];
    for (var task in this) {
      if (task.statusEntity == status) {
        result.add(task);
      }
    }
    return result;
  }
}
