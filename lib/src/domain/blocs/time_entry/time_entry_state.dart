part of 'time_entry_bloc.dart';

class TimeEntryState {
  final TimeEntryEntity timeEntry;
  final bool isLoading;
  final String error;

  const TimeEntryState({
    required this.timeEntry,
    this.isLoading = false,
    this.error = '',
  });

  TimeEntryState copyWith({
    TimeEntryEntity? timeEntry,
    bool? isLoading,
    String? error,
  }) {
    return TimeEntryState(
      timeEntry: timeEntry ?? this.timeEntry,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'TimeEntryState(timeEntry: $timeEntry, isLoading: $isLoading, error: $error)';
}

class TimeEntryUpdatedState extends TimeEntryState {
  TimeEntryUpdatedState({required super.timeEntry});
}

class TimeEntryDeletedState extends TimeEntryState {
  TimeEntryDeletedState({required super.timeEntry});
}
