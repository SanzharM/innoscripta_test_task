import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

abstract class TimeEntryRepository {
  Future<TimeEntryEntity> start(DateTime date, {int? taskId, bool isGlobal = false});

  Future<TimeEntryEntity> end(TimeEntryEntity timeEntryEntity);

  Future<bool> update(TimeEntryEntity timeEntryEntity);

  Future<List<TimeEntryEntity>> getEntries({int? taskId});

  Future<bool> delete(TimeEntryEntity timeEntryEntity);
}
