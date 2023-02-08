part of 'board_bloc.dart';

class BoardState {
  final BoardEntity board;
  final int currentColumnIndex;
  final bool isLoading;
  final String error;

  const BoardState({
    required this.board,
    this.currentColumnIndex = -1,
    this.isLoading = false,
    this.error = '',
  });

  BoardState copyWith({
    BoardEntity? board,
    int? currentColumnIndex,
    bool? isLoading,
    String? error,
  }) {
    return BoardState(
      board: board ?? this.board,
      currentColumnIndex: currentColumnIndex ?? this.currentColumnIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() => 'BoardState(board: $board, currentColumnIndex: $currentColumnIndex, isLoading: $isLoading, error: $error)';
}

class BoardCreatedState extends BoardState {
  const BoardCreatedState({
    required super.board,
    required super.currentColumnIndex,
  });
}
