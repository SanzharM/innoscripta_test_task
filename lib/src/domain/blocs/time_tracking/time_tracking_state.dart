part of 'time_tracking_bloc.dart';

class TimeTrackingState {
  final DateTime? startTime;
  final int currentDuration;
  final bool isFinished;
  final bool isLoading;
  final String error;

  const TimeTrackingState({
    this.startTime,
    this.currentDuration = 0,
    this.isFinished = true,
    this.isLoading = false,
    this.error = '',
  });

  TimeTrackingState copyWith({
    DateTime? startTime,
    int? currentDuration,
    bool? isFinished,
    bool? isLoading,
    String? error,
  }) {
    return TimeTrackingState(
      startTime: startTime ?? this.startTime,
      currentDuration: currentDuration ?? this.currentDuration,
      isFinished: isFinished ?? this.isFinished,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() {
    return 'TimeTrackingState(startTime: $startTime, currentDuration: $currentDuration, isFinished: $isFinished, isLoading: $isLoading, error: $error)';
  }
}

class TimerTrackingStartedState extends TimeTrackingState {
  final int? taskId;

  TimerTrackingStartedState({
    required super.startTime,
    this.taskId,
  });
}

class TimerTrackingFinishedState extends TimeTrackingState {
  final TimeEntryEntity timeEntryEntity;

  TimerTrackingFinishedState(this.timeEntryEntity);
}
