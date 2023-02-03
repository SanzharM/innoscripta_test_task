import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  void changeTab(int index) => add(NavBarChangeTabEvent(index));

  NavBarBloc() : super(const NavBarState()) {
    on<NavBarChangeTabEvent>(_changeTab);
  }

  void _changeTab(NavBarChangeTabEvent event, Emitter<NavBarState> emit) {
    return emit(state.copyWith(currentIndex: event.index));
  }
}
