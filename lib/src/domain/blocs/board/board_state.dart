part of 'board_bloc.dart';

class BoardState {
  final BoardEntity board;
  final int currentColumnIndex;
  final bool isLoading;
  final String error;
  final double totalHours;

  const BoardState({
    required this.board,
    this.currentColumnIndex = -1,
    this.isLoading = false,
    this.error = '',
    this.totalHours = 0.0,
  });

  BoardState copyWith({
    BoardEntity? board,
    int? currentColumnIndex,
    bool? isLoading,
    String? error,
    double? totalHours,
  }) {
    return BoardState(
      board: board ?? this.board,
      currentColumnIndex: currentColumnIndex ?? this.currentColumnIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
      totalHours: totalHours ?? this.totalHours,
    );
  }

  @override
  String toString() {
    return 'BoardState(board: $board, currentColumnIndex: $currentColumnIndex, isLoading: $isLoading, error: $error, totalHours: $totalHours)';
  }
}

class BoardCreatedState extends BoardState {
  const BoardCreatedState({
    required super.board,
    required super.currentColumnIndex,
  });
}

class BoardDeletedState extends BoardState {
  const BoardDeletedState({
    required super.board,
    required super.currentColumnIndex,
  });
}
