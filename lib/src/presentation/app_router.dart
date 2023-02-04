import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/presentation/screens/add_board/add_board_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/board/board_screen.dart';
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
  static CupertinoPageRoute<T> _routeBuilder<T>(Widget screen) => CupertinoPageRoute(builder: (_) => screen);

  NavigatorState get _navigator => Navigator.of(state.currentContext!);

  Future<T?> push<T>(Widget screen) async {
    return _navigator.push<T>(_routeBuilder<T>(screen));
  }

  void back() => _navigator.canPop() ? _navigator.pop() : null;

  // ROUTING
  static final initialRoute = routes.keys.first;
  static final routes = <String, Widget Function(BuildContext context)>{
    _Routes.initial: (_) => const NavBar(),
    _Routes.home: (_) => const HomeScreen(),
    _Routes.settings: (_) => const SettingsScreen(),
    _Routes.addBoard: (_) => const AddBoardScreen(),
    _Routes.board: (_) {
      final args = ModalRoute.of(_)?.settings.arguments as BoardEntity;
      return BlocProvider<BoardBloc>(
        create: (_) => BoardBloc(args),
        child: const BoardScreen(),
      );
    },
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    debugPrint('onGenerateRoute: ${settings.name}');
    return null;
  }

  // SHORTCUTS
  void toHomeScreen() => _navigator.pushNamed(_Routes.home);
  void toSettingsScreen() => _navigator.pushNamed(_Routes.settings);
  void toAddBoardScreen() => _navigator.pushNamed(_Routes.addBoard);
  void toBoardScreen(BoardEntity boardEntity) => _navigator.pushNamed(_Routes.board, arguments: boardEntity);
}

class _Routes {
  static const initial = '';
  static const home = '/home';
  static const addBoard = '/addBoard';
  static const settings = '/settings';
  static const board = '/board';
}
