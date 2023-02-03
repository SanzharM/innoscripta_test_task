import 'package:flutter/cupertino.dart';
import 'package:innoscripta_test_task/src/presentation/screens/home/components/add_board/add_board_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/home/home_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/nav_bar/nav_bar.dart';
import 'package:innoscripta_test_task/src/presentation/screens/settings/settings_screen.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

extension ContextRouter on BuildContext {
  AppRouter get router => sl<AppRouter>();
}

class AppRouter {
  const AppRouter();

  static GlobalKey<NavigatorState> state = GlobalKey<NavigatorState>();

  // COMMON
  CupertinoPageRoute<T> _routeBuilder<T>(Widget screen) => CupertinoPageRoute(builder: (_) => screen);

  NavigatorState get _navigator => Navigator.of(state.currentContext!);

  Future<T?> push<T>(Widget screen) async {
    return _navigator.push<T>(_routeBuilder<T>(screen));
  }

  // ROUTING
  static final initialRoute = routes.keys.first;
  static final routes = <String, Widget Function(BuildContext context)>{
    _Routes.initial: (_) => const NavBar(),
    _Routes.home: (_) => const HomeScreen(),
    _Routes.addBoard: (_) => const AddBoardScreen(),
    _Routes.settings: (_) => const SettingsScreen(),
  };

  // SHORTCUTS
  void toHomeScreen() => _navigator.pushNamed(_Routes.home);
  void toSettingsScreen() => _navigator.pushNamed(_Routes.settings);
  void toAddBoardScreen() => _navigator.pushNamed(_Routes.addBoard);
}

class _Routes {
  static const initial = '/';
  static const home = '/home';
  static const addBoard = '/addBoard';
  static const settings = '/settings';
}
