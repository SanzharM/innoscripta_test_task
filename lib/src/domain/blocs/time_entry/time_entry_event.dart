part of 'time_entry_bloc.dart';

@immutable
abstract class TimeEntryEvent {}

class TimeEntryGetEvent extends TimeEntryEvent {}

class TimeEntryUpdateEvent extends TimeEntryEvent {
  final TimeEntryEntity timeEntryEntity;

  TimeEntryUpdateEvent(this.timeEntryEntity);
}

class TimeEntryDeleteEvent extends TimeEntryEvent {
  final TimeEntryEntity timeEntryEntity;

  TimeEntryDeleteEvent(this.timeEntryEntity);
}
