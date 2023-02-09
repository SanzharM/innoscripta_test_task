import 'package:innoscripta_test_task/src/data/datasources/time_entry/time_entry_data_source.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/time_entry/time_entry_repository.dart';

class TimeEntryRepositoryImpl implements TimeEntryRepository {
  final TimeEntryDataSource dataSource;

  TimeEntryRepositoryImpl(this.dataSource);

  @override
  Future<TimeEntryEntity> start(DateTime date, {int? taskId}) {
    return dataSource.start(date, taskId: taskId);
  }

  @override
  Future<TimeEntryEntity> end(TimeEntryEntity timeEntryEntity) {
    return dataSource.end(timeEntryEntity);
  }

  @override
  Future<bool> update(TimeEntryEntity timeEntryEntity) {
    return dataSource.update(timeEntryEntity);
  }
}
