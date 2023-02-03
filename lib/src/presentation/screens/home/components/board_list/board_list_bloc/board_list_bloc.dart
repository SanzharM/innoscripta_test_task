import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'board_list_event.dart';
part 'board_list_state.dart';

class BoardListBloc extends Bloc<BoardListEvent, BoardListState> {
  void fetch() => add(BoardListFetchEvent());

  BoardListBloc() : super(const BoardListState()) {
    on<BoardListFetchEvent>(_fetch);
  }

  final _repository = sl<BoardRepository>();

  void _fetch(BoardListFetchEvent event, Emitter<BoardListState> emit) async {
    print('fetch');
    if (state.isLoading) return;
    if (state.page != 1 && !state.canLoadMore) return;

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.fetchBoards(state.page);

      var boards = List<BoardEntity>.from(state.boards);
      emit(state.copyWith(
        isLoading: false,
        boards: boards..addAll(response.items),
        page: state.page + 1,
        total: response.total,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
