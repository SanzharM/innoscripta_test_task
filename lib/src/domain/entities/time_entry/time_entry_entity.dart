class TimeEntryEntity {
  final DateTime startTime;
  final DateTime? endTime;
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
