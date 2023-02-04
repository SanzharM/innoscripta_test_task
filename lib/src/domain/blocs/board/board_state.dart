part of 'board_bloc.dart';

class BoardState {
  final BoardEntity board;
  final bool isLoading;
  final String error;

  const BoardState({
    required this.board,
    this.isLoading = false,
    this.error = '',
  });

  BoardState copyWith({
    BoardEntity? board,
    bool? isLoading,
    String? error,
  }) {
    return BoardState(
      board: board ?? this.board,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() => 'BoardState(board: $board, isLoading: $isLoading, error: $error)';
}
