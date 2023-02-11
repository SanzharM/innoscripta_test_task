import 'package:hive/hive.dart';
import 'package:innoscripta_test_task/src/core/storage/hive_storage.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

abstract class TimeEntryDataSource {
  Future<TimeEntryEntity> start(DateTime date, {int? taskId, bool isGlobal = false});

  Future<TimeEntryEntity> end(TimeEntryEntity timeEntryEntity);

  Future<bool> update(TimeEntryEntity timeEntryEntity);

  Future<List<TimeEntryEntity>> getEntries({int? taskId});

  Future<bool> delete(TimeEntryEntity timeEntryEntity);
}

class TimeEntryDataSourceImpl implements TimeEntryDataSource {
  Box<TimeEntryEntity> get box => Hive.box<TimeEntryEntity>(HiveStorage.timeEntryBox);

  @override
  Future<TimeEntryEntity> start(DateTime date, {int? taskId, bool isGlobal = false}) async {
    if (box.values.any((e) => e.endTime == null)) {
      throw Exception('You have already opened time entry.');
    }

    final timeEntry = TimeEntryEntity(
      startTime: date,
      endTime: null,
      description: null,
      taskId: taskId,
      isGlobal: isGlobal,
    );
    await box.add(timeEntry);
    return timeEntry;
  }

  @override
  Future<TimeEntryEntity> end(TimeEntryEntity timeEntryEntity) async {
    int index = box.values.toList().indexOf(timeEntryEntity);
    if (index <= -1) {
      throw Exception('Unable to close time entry: TimeEntry not found.');
    }

    var entity = timeEntryEntity.copyWith(endTime: DateTime.now());
    await box.deleteAt(index);
    await box.add(entity);
    return entity;
  }

  @override
  Future<bool> update(TimeEntryEntity timeEntryEntity) async {
    int index = box.values.toList().indexOf(timeEntryEntity);
    if (index <= -1) {
      return false;
    }

    await box.deleteAt(index);
    await box.add(timeEntryEntity);
    return true;
  }

  @override
  Future<List<TimeEntryEntity>> getEntries({int? taskId}) async {
    var entries = List<TimeEntryEntity>.from(box.values.toList().reversed);
    if (taskId == null) {
      return entries;
    }

    entries = entries.where((e) => e.taskId == taskId).toList();
    entries.sort((a, b) => a.startTime.compareTo(b.startTime));
    return entries;
  }

  @override
  Future<bool> delete(TimeEntryEntity timeEntryEntity) async {
    int index = box.values.toList().indexOf(timeEntryEntity);
    if (index <= -1) {
      return false;
    }

    await box.deleteAt(index);
    return true;
  }
}
