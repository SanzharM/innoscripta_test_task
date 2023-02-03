part of 'nav_bar_bloc.dart';

@immutable
abstract class NavBarEvent {}

class NavBarChangeTabEvent extends NavBarEvent {
  final int index;

  NavBarChangeTabEvent(this.index);
}
