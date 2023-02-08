import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  void get(TaskEntity task) => add(TaskGetEvent(task));
  void update(TaskEntity task) => add(TaskUpdateEvent(task));
  void delete(TaskEntity task) => add(TaskDeleteEvent(task));

  TaskBloc(TaskEntity task) : super(TaskState(task: task)) {
    on<TaskGetEvent>(_get);
    on<TaskUpdateEvent>(_update);
    on<TaskDeleteEvent>(_delete);
  }

  final _repository = sl<TaskRepository>();
  final _boardRepository = sl<BoardRepository>();

  void _get(TaskGetEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final response = await _repository.getTask(event.task.id);
      emit(state.copyWith(isLoading: false, task: response));
      if (response.boardId != null) {
        final relatedBoard = await _boardRepository.getBoard(response.boardId!);
        emit(state.copyWith(board: relatedBoard));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _update(TaskUpdateEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      var updatedTask = event.task.copyWith(updatedAt: DateTime.now());
      final response = await _repository.editTask(updatedTask);
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
}
