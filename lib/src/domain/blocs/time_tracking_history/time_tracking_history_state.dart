part of 'time_tracking_history_bloc.dart';

class TimeTrackingHistoryState {
  final List<TimeEntryEntity> timeEntries;
  final bool isLoading;
  final String error;

  const TimeTrackingHistoryState({
    this.timeEntries = const [],
    this.isLoading = false,
    this.error = '',
  });

  TimeTrackingHistoryState copyWith({
    List<TimeEntryEntity>? timeEntries,
    bool? isLoading,
    String? error,
  }) {
    return TimeTrackingHistoryState(
      timeEntries: timeEntries ?? this.timeEntries,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() => 'TimeTrackingHistoryState(timeEntries: $timeEntries, isLoading: $isLoading, error: $error)';
}
