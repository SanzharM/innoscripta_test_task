import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  void changeColumnIndex(int index) => add(BoardChangeColumnIndexEvent(index));
  void update(BoardEntity board) => add(BoardUpdateEvent(board));
  // void refresh() => add(BoardRefreshEvent());
  void createTask(String name) => add(BoardCreateTaskEvent(name));
  void fetch() => add(BoardFetchEvent());
  void reorder(int from, int to) => add(BoardReorderEvent(from, to));

  BoardBloc(this.boardEntity)
      : super(BoardState(
          board: boardEntity,
          currentColumnIndex: boardEntity.statuses.isEmpty ? -1 : 0,
        )) {
    on<BoardUpdateEvent>(_updateBoard);
    on<BoardRefreshEvent>(_refreshBoard);
    on<BoardChangeColumnIndexEvent>(_changeColumnIndex);
    on<BoardCreateTaskEvent>(_createTask);
    on<BoardFetchEvent>(_fetch);
    on<BoardReorderEvent>(_reorder);
  }

  final BoardEntity boardEntity;
  final _repository = sl<BoardRepository>();
  final _taskRepository = sl<TaskRepository>();

  void _updateBoard(BoardUpdateEvent event, Emitter<BoardState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _repository.updateBoard(event.boardEntity);
      if (response) {
        return emit(state.copyWith(isLoading: false, board: event.boardEntity));
      }
      emit(state.copyWith(
        isLoading: false,
        error: 'Unable to update board ${event.boardEntity.name}',
      ));
    } catch (e) {
      debugPrint('BoardUpdateEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _refreshBoard(BoardRefreshEvent event, Emitter<BoardState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _repository.getBoard(state.board.id);
      emit(state.copyWith(isLoading: false, board: response));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _changeColumnIndex(BoardChangeColumnIndexEvent event, Emitter<BoardState> emit) {
    return emit(state.copyWith(currentColumnIndex: event.index));
  }

  void _createTask(BoardCreateTaskEvent event, Emitter<BoardState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    try {
      StatusEntity? status;
      if (state.board.statuses.isNotEmpty) {
        status = state.board.statuses.elementAt(state.currentColumnIndex);
      }
      final response = await _taskRepository.createTask(
        name: event.name,
        boardId: state.board.id,
        status: status,
      );
      var tasks = List<TaskEntity>.from(state.board.tasks);
      emit(BoardCreatedState(
        board: state.board.copyWith(tasks: tasks..add(response)),
        currentColumnIndex: state.currentColumnIndex,
      ));
      return fetch();
    } catch (e) {
      debugPrint('BoardCreateTaskEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _fetch(BoardFetchEvent event, Emitter<BoardState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await _repository.getBoard(boardEntity.id);
      final tasks = await _taskRepository.getTasksFromBoard(state.board.id);
      emit(state.copyWith(
        isLoading: false,
        board: response.copyWith(tasks: tasks),
      ));
    } catch (e) {
      debugPrint('BoardFetchEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _reorder(BoardReorderEvent event, Emitter<BoardState> emit) async {
    var tasks = List<TaskEntity>.from(state.board.tasks);
    var targetTask = tasks[event.from];
    tasks
      ..removeAt(event.from)
      ..insert(event.to, targetTask);
    return emit(state.copyWith(board: state.board.copyWith(tasks: tasks)));
  }
}
