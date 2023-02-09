import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/time_entry/time_entry_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  void get(TaskEntity task) => add(TaskGetEvent(task));
  void update(TaskEntity task) => add(TaskUpdateEvent(task));
  void delete(TaskEntity task) => add(TaskDeleteEvent(task));
  void startTimeEntry() => add(TaskStartTimeEntryEvent());
  void finishTimeEntry() => add(TaskFinishTimeEntryEvent());

  TaskBloc(TaskEntity task) : super(TaskState(task: task)) {
    on<TaskGetEvent>(_get);
    on<TaskUpdateEvent>(_update);
    on<TaskDeleteEvent>(_delete);
    on<TaskStartTimeEntryEvent>(_startTimeEntry);
    on<TaskFinishTimeEntryEvent>(_finishTimeEntry);
  }

  final _repository = sl<TaskRepository>();
  final _boardRepository = sl<BoardRepository>();
  final _timeEntryRepository = sl<TimeEntryRepository>();

  void _get(TaskGetEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _repository.getTask(event.task.id);
      emit(state.copyWith(isLoading: false, task: response));

      if (response.boardId != null) {
        final relatedBoard = await _boardRepository.getBoard(response.boardId!);
        emit(state.copyWith(
          board: relatedBoard,
        ));
      }

      final timeEntries = await _timeEntryRepository.getEntries(taskId: state.task.id);
      emit(state.copyWith(
        task: state.task.copyWith(timeEntries: timeEntries),
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _update(TaskUpdateEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      var timeEntries = event.task.timeEntries.where((e) => e.isValid).toList();
      var updatedTask = event.task.copyWith(updatedAt: DateTime.now(), timeEntries: timeEntries);
      final response = await _repository.editTask(updatedTask.copyWith(timeEntries: []));

      if (response) {
        return emit(TaskUpdatedState(task: updatedTask, board: state.board));
      }
      emit(state.copyWith(isLoading: false, error: 'Something went wrong'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _delete(TaskDeleteEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _repository.deleteTask(event.task);
      if (response) {
        return emit(TaskDeletedState(task: event.task, board: state.board));
      }
      emit(state.copyWith(isLoading: false, error: 'Something went wrong'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _startTimeEntry(TaskStartTimeEntryEvent event, Emitter<TaskState> emit) async {
    final task = state.task;
    var timeEntries = List<TimeEntryEntity>.from(task.timeEntries).where((e) => e.isValid).toList();

    final newTimeEntry = await _timeEntryRepository.start(DateTime.now(), taskId: task.id);

    return emit(state.copyWith(
      task: task.copyWith(timeEntries: timeEntries..add(newTimeEntry)),
    ));
  }

  void _finishTimeEntry(TaskFinishTimeEntryEvent event, Emitter<TaskState> emit) async {
    final task = state.task;
    var timeEntries = List<TimeEntryEntity>.from(task.timeEntries).toList();

    if (!timeEntries.last.isActive) return;

    timeEntries[timeEntries.length - 1] = timeEntries.last.copyWith(endTime: DateTime.now());
    if (timeEntries.last.isInvalid) {
      var temp = timeEntries.removeLast();
      await _timeEntryRepository.delete(temp);
    } else {
      await _timeEntryRepository.update(timeEntries.last);
    }

    return emit(state.copyWith(
      task: task.copyWith(timeEntries: timeEntries),
    ));
  }
}
