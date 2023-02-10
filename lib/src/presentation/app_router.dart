import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/task/task_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_entry/time_entry_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/screens/add_board/add_board_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/board/board_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/home/home_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/nav_bar/nav_bar.dart';
import 'package:innoscripta_test_task/src/presentation/screens/settings/languages_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/settings/settings_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/settings/themes_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/task/components/task_description_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/task/task_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/time_tracking/components/time_entry_screen.dart';
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
    _Routes.task: (_) {
      final args = ModalRoute.of(_)?.settings.arguments as TaskEntity;
      return BlocProvider<TaskBloc>(
        create: (_) => TaskBloc(args),
        child: const TaskScreen(),
      );
    },
    _Routes.taskDescription: (_) {
      final args = ModalRoute.of(_)?.settings.arguments as TaskBloc;
      return BlocProvider<TaskBloc>.value(
        value: args,
        child: const TaskDescriptionScreen(),
      );
    },
    _Routes.timeEntries: (_) {
      final args = ModalRoute.of(_)?.settings.arguments as TimeEntryEntity;
      return BlocProvider<TimeEntryBloc>(
        create: (_) => TimeEntryBloc(args),
        child: const TimeEntryScreen(),
      );
    },
    _Routes.languages: (_) => const LanguagesScreen(),
    _Routes.themes: (_) => const ThemesScreen(),
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
  Future<void> toTaskScreen(TaskEntity taskEntity) => _navigator.pushNamed(_Routes.task, arguments: taskEntity);
  Future<void> toTaskDescriptionScreen(TaskBloc bloc) => _navigator.pushNamed(_Routes.taskDescription, arguments: bloc);
  void toLanguagesScreen() => _navigator.pushNamed(_Routes.languages);
  void toThemesScreen() => _navigator.pushNamed(_Routes.themes);
  Future<void> toTimeEntryScreen(TimeEntryEntity timeEntry) => _navigator.pushNamed(_Routes.timeEntries, arguments: timeEntry);
}

class _Routes {
  static const initial = '';
  static const home = '/home';
  static const addBoard = '/addBoard';
  static const settings = '/settings';
  static const board = '/board';
  static const task = '/task';
  static const taskDescription = '/taskDescription';
  static const languages = '/languages';
  static const themes = '/themes';
  static const timeEntries = '/timeEntries';
}
