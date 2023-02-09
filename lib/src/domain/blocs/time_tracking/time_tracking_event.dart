part of 'time_tracking_bloc.dart';

@immutable
abstract class TimeTrackingEvent {}

class TimeTrackingStartEvent extends TimeTrackingEvent {
  final int? taskId;

  TimeTrackingStartEvent({this.taskId});
}

class TimeTrackingTickEvent extends TimeTrackingEvent {
  final int ticks;

  TimeTrackingTickEvent(this.ticks);
}

class TimeTrackingFinishEvent extends TimeTrackingEvent {
  final TimeEntryEntity timeEntryEntity;

  TimeTrackingFinishEvent(this.timeEntryEntity);
}
