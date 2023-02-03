part of 'nav_bar_bloc.dart';

class NavBarState {
  final int currentIndex;

  const NavBarState({
    this.currentIndex = 0,
  });

  NavBarState copyWith({
    int? currentIndex,
  }) {
    return NavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
