part of 'board_list_bloc.dart';

class BoardListState {
  final List<BoardEntity> boards;
  final int page;
  final int total;
  final bool isLoading;
  final String error;

  const BoardListState({
    this.boards = const [],
    this.page = 1,
    this.total = 0,
    this.isLoading = false,
    this.error = '',
  });

  bool get canLoadMore => boards.length <= total;

  BoardListState copyWith({
    List<BoardEntity>? boards,
    int? page,
    int? total,
    bool? isLoading,
    String? error,
  }) {
    return BoardListState(
      boards: boards ?? this.boards,
      page: page ?? this.page,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }
}

class BoardListAddedState extends BoardListState {
  const BoardListAddedState({
    required super.boards,
    required super.page,
    required super.total,
  });
}
