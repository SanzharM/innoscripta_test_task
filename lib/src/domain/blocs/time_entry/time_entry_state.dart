part of 'time_entry_bloc.dart';

class TimeEntryState {
  final TimeEntryEntity timeEntry;
  final TaskEntity? taskEntity;
  final bool isLoading;
  final String error;

  const TimeEntryState({
    required this.timeEntry,
    this.taskEntity,
    this.isLoading = false,
    this.error = '',
  });

  TimeEntryState copyWith({
    TimeEntryEntity? timeEntry,
    TaskEntity? taskEntity,
    bool? isLoading,
    String? error,
  }) {
    return TimeEntryState(
      timeEntry: timeEntry ?? this.timeEntry,
      taskEntity: taskEntity ?? this.taskEntity,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() {
    return 'TimeEntryState(timeEntry: $timeEntry, taskEntity: $taskEntity, isLoading: $isLoading, error: $error)';
  }
}

class TimeEntryUpdatedState extends TimeEntryState {
  TimeEntryUpdatedState({required super.timeEntry, super.taskEntity});
}

class TimeEntryDeletedState extends TimeEntryState {
  TimeEntryDeletedState({required super.timeEntry, super.taskEntity});
}
