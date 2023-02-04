import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  void update(BoardEntity board) => add(BoardUpdateEvent(board));

  BoardBloc(this.boardEntity) : super(BoardState(board: boardEntity)) {
    on<BoardUpdateEvent>(_updateBoard);
  }

  final BoardEntity boardEntity;
  final _repository = sl<BoardRepository>();

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
}
