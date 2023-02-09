import 'package:hive/hive.dart';

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

  const TimeEntryEntity({
    required this.startTime,
    this.endTime,
    this.description,
    this.taskId,
  });

  bool get isActive => endTime == null;

  TimeEntryEntity copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    int? taskId,
  }) {
    return TimeEntryEntity(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      taskId: taskId ?? this.taskId,
    );
  }

  TimeEntryEntity finish() => copyWith(endTime: DateTime.now());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeEntryEntity &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.description == description &&
        other.taskId == taskId;
  }

  @override
  int get hashCode {
    return startTime.hashCode ^ endTime.hashCode ^ description.hashCode ^ taskId.hashCode;
  }

  @override
  String toString() {
    return 'TimeEntryEntity(startTime: $startTime, endTime: $endTime, description: $description, taskId: $taskId)';
  }
}
