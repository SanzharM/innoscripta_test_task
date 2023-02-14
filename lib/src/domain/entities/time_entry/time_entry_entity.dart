import 'package:hive/hive.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';

part 'time_entry_entity.g.dart';

@HiveType(typeId: 0)
class TimeEntryEntity {
  @HiveField(0)
  final DateTime startTime;
  @HiveField(1)
  final DateTime? endTime;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final int? taskId;
  @HiveField(4)
  final bool isGlobal;

  const TimeEntryEntity({
    required this.startTime,
    this.endTime,
    this.description,
    this.taskId,
    this.isGlobal = false,
  });

  String get readableFormat => '${Utils.formatDate(startTime, format: 'HH:mm:ss')}'
      ' - '
      '${Utils.formatDate(endTime, format: 'HH:mm:ss') ?? ' ...'}';
  double get totalHours {
    return (endTime ?? DateTime.now()).difference(startTime).inSeconds / 60 / 60;
  }

  bool get isActive => endTime == null;

  bool get isValid => !isInvalid;

  bool get isInvalid {
    if (endTime == null) return false;

    if (endTime!.isBefore(startTime)) {
      return true;
    } else if (endTime!.difference(startTime).inSeconds < 3) {
      return true;
    }

    return false;
  }

  TimeEntryEntity finish() => copyWith(endTime: DateTime.now());

  TimeEntryEntity copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    int? taskId,
    bool? isGlobal,
  }) {
    return TimeEntryEntity(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      taskId: taskId ?? this.taskId,
      isGlobal: isGlobal ?? this.isGlobal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeEntryEntity &&
        other.startTime.millisecondsSinceEpoch == startTime.millisecondsSinceEpoch &&
        // other.endTime == endTime &&
        // other.description == description &&
        // other.taskId == taskId &&
        other.isGlobal == isGlobal;
  }

  @override
  int get hashCode {
    return startTime.hashCode ^ endTime.hashCode ^ description.hashCode ^ taskId.hashCode ^ isGlobal.hashCode;
  }

  @override
  String toString() {
    return 'TimeEntryEntity(startTime: $startTime, endTime: $endTime, description: $description, taskId: $taskId, isGlobal: $isGlobal)';
  }

  static List<String> csvColumnNames = <String>['Total', 'Start time', 'End time', 'Description'];

  List<dynamic> toCsv() {
    const format = 'dd.MM.yyyy HH:mm:ss';
    return [
      Utils.formatDate(startTime, format: format),
      Utils.formatDate(endTime, format: format),
      description ?? '',
    ];
  }
}
