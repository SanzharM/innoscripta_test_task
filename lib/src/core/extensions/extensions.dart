import 'package:flutter/cupertino.dart';
import 'package:innoscripta_test_task/src/core/exceptions/exceptions.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

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

  double get totalSpentHours {
    int seconds = 0;
    for (var task in this) {
      seconds += task.timeEntries.totalSpentTime.inSeconds;
    }

    return double.parse((seconds / 60 / 60).toStringAsPrecision(2));
  }
}

extension XDateTime on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool get isYesterday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day - 1 == day;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day + 1 == day;
  }
}

extension XDuration on Duration {
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}

extension XLanguageName on Locale {
  String get languageName {
    switch (languageCode.toLowerCase()) {
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      default:
        return languageCode;
    }
  }
}

extension XTimeEntries on List<TimeEntryEntity> {
  Duration get totalSpentTime {
    int totalSeconds = 0;
    for (var timeEntry in this) {
      if (timeEntry.isActive) continue;

      final duration = timeEntry.endTime!.difference(timeEntry.startTime).inSeconds;
      totalSeconds += duration;
    }
    return Duration(seconds: totalSeconds);
  }
}
