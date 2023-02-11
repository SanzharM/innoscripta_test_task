part of 'time_tracking_bloc.dart';

class TimeTrackingState {
  final TimeEntryEntity? timeEntry;
  final int currentDuration;
  final bool isLoading;
  final String error;

  const TimeTrackingState({
    this.currentDuration = 0,
    this.timeEntry,
    this.isLoading = false,
    this.error = '',
  });

  bool get isActive => timeEntry?.isActive ?? false;
  bool get isNotActive => !isActive;

  TimeTrackingState copyWith({
    int? currentDuration,
    TimeEntryEntity? timeEntry,
    bool? isLoading,
    String? error,
  }) {
    return TimeTrackingState(
      currentDuration: currentDuration ?? this.currentDuration,
      timeEntry: timeEntry ?? this.timeEntry,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() {
    return 'TimeTrackingState(currentDuration: $currentDuration, timeEntry: $timeEntry, isLoading: $isLoading, error: $error)';
  }
}

class TimerTrackingStartedState extends TimeTrackingState {
  final int? taskId;

  TimerTrackingStartedState({
    required super.timeEntry,
    this.taskId,
  });
}

class TimerTrackingFinishedState extends TimeTrackingState {
  TimerTrackingFinishedState({required super.timeEntry});
}
