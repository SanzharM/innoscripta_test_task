part of 'time_tracking_history_bloc.dart';

@immutable
abstract class TimeTrackingHistoryEvent {}

class TimeTrackingHistoryResetEvent extends TimeTrackingHistoryEvent {}

class TimeTrackingHistoryFetchEvent extends TimeTrackingHistoryEvent {}
