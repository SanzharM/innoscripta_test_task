import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'board_list_event.dart';
part 'board_list_state.dart';

class BoardListBloc extends Bloc<BoardListEvent, BoardListState> {
  void reset() => add(BoardListResetEvent());
  void fetch() => add(BoardListFetchEvent());
  void addBoard(String name) => add(BoardListAddEvent(name));

  BoardListBloc() : super(const BoardListState()) {
    on<BoardListResetEvent>(_reset);
    on<BoardListFetchEvent>(_fetch);
    on<BoardListAddEvent>(_addBoard);
  }

  final _repository = sl<BoardRepository>();

  void _reset(BoardListResetEvent event, Emitter<BoardListState> emit) async {
    emit(const BoardListState());
  }

  void _fetch(BoardListFetchEvent event, Emitter<BoardListState> emit) async {
    if (state.isLoading) return;
    if (state.page != 1 && !state.canLoadMore) return;

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.fetchBoards(state.page);

      var currentBoards = List<BoardEntity>.from(state.boards);
      emit(state.copyWith(
        isLoading: false,
        boards: currentBoards..addAll(response.items),
        page: state.page + 1,
        total: response.total,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _addBoard(BoardListAddEvent event, Emitter<BoardListState> emit) async {
    if (event.name.isEmpty) {
      return emit(state.copyWith(error: 'Invalid name'));
    }
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.addBoard(event.name);
      if (response) {
        emit(BoardListAddedState(
          boards: state.boards,
          page: 1,
          total: state.total,
        ));
        return fetch();
      }
      emit(state.copyWith(isLoading: false, error: 'Unable to add board ${event.name}'));
    } catch (e) {
      debugPrint('BoardListAddEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
