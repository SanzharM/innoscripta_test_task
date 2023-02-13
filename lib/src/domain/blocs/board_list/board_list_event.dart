part of 'board_list_bloc.dart';

@immutable
abstract class BoardListEvent {}

class BoardListResetEvent extends BoardListEvent {}

class BoardListFetchEvent extends BoardListEvent {}

class BoardListRefreshEvent extends BoardListEvent {}

class BoardListAddEvent extends BoardListEvent {
  final String name;

  BoardListAddEvent(this.name);
}
