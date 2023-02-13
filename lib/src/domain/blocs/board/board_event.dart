part of 'board_bloc.dart';

@immutable
abstract class BoardEvent {}

class BoardUpdateEvent extends BoardEvent {
  final BoardEntity boardEntity;

  BoardUpdateEvent(this.boardEntity);
}

class BoardChangeColumnIndexEvent extends BoardEvent {
  final int index;

  BoardChangeColumnIndexEvent(this.index);
}

class BoardCreateTaskEvent extends BoardEvent {
  final String name;

  BoardCreateTaskEvent(this.name);
}

class BoardFetchEvent extends BoardEvent {}

class BoardReorderEvent extends BoardEvent {
  final int from;
  final int to;

  BoardReorderEvent(this.from, this.to);
}

class BoardDeleteEvent extends BoardEvent {
  final int id;

  BoardDeleteEvent(this.id);
}
