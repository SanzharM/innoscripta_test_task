import 'package:hive_flutter/adapters.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

class HiveStorage {
  HiveStorage();

  static const timeEntryBox = 'TimeEntryBox';
  static const statusBox = 'StatusBox';
  static const taskBox = 'TaskBox';
  static const boardBox = 'BoardBox';

  Future<void> initialize() async {
    await Hive.initFlutter();

    // Time Entries
    if (!Hive.isAdapterRegistered(TimeEntryEntityAdapter().typeId)) {
      Hive.registerAdapter<TimeEntryEntity>(TimeEntryEntityAdapter());
    }
    if (!Hive.isBoxOpen(timeEntryBox)) {
      await Hive.openBox<TimeEntryEntity>(timeEntryBox);
    }

    // Statuses
    if (!Hive.isAdapterRegistered(StatusEntityAdapter().typeId)) {
      Hive.registerAdapter<StatusEntity>(StatusEntityAdapter());
    }
    if (!Hive.isBoxOpen(statusBox)) {
      await Hive.openBox<StatusEntity>(statusBox);
    }

    // Tasks
    if (!Hive.isAdapterRegistered(TaskEntityAdapter().typeId)) {
      Hive.registerAdapter<TaskEntity>(TaskEntityAdapter());
    }
    if (!Hive.isBoxOpen(taskBox)) {
      await Hive.openBox<TaskEntity>(taskBox);
    }

    // Boards
    if (!Hive.isAdapterRegistered(BoardEntityAdapter().typeId)) {
      Hive.registerAdapter<BoardEntity>(BoardEntityAdapter());
    }
    if (!Hive.isBoxOpen(boardBox)) {
      await Hive.openBox<BoardEntity>(boardBox);
    }
  }

  Future<void> clear() async {
    // await Hive.deleteBoxFromDisk(boardBox);
    // await Hive.deleteBoxFromDisk(taskBox);
    // await Hive.deleteBoxFromDisk(statusBox);
    // await Hive.deleteBoxFromDisk(timeEntryBox);
    return await Hive.deleteFromDisk();
  }

  Future<void> reset() {
    return clear().then((value) => initialize());
  }
}
