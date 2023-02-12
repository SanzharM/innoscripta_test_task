part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class TaskGetEvent extends TaskEvent {
  final TaskEntity task;

  TaskGetEvent(this.task);
}

class TaskUpdateEvent extends TaskEvent {
  final TaskEntity task;

  TaskUpdateEvent(this.task);
}

class TaskDeleteEvent extends TaskEvent {
  final TaskEntity task;

  TaskDeleteEvent(this.task);
}

class TaskStartTimeEntryEvent extends TaskEvent {}

class TaskFinishTimeEntryEvent extends TaskEvent {}

class TaskDoneEvent extends TaskEvent {
  final TaskEntity task;

  TaskDoneEvent(this.task);
}

class TaskSetDeadlineEvent extends TaskEvent {
  final DateTime date;

  TaskSetDeadlineEvent(this.date);
}

class TaskRemoveDeadlineEvent extends TaskEvent {}
