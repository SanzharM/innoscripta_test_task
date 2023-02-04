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

  const TimeEntryEntity({
    required this.startTime,
    this.endTime,
    this.description,
  });

  TimeEntryEntity copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? description,
  }) {
    return TimeEntryEntity(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeEntryEntity && other.startTime == startTime && other.endTime == endTime && other.description == description;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode ^ description.hashCode;

  @override
  String toString() => 'TimeEntryEntity(startTime: $startTime, endTime: $endTime, description: $description)';
}
