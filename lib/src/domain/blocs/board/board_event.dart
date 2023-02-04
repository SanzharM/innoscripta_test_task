part of 'board_bloc.dart';

@immutable
abstract class BoardEvent {}

class BoardUpdateEvent extends BoardEvent {
  final BoardEntity boardEntity;

  BoardUpdateEvent(this.boardEntity);
}
