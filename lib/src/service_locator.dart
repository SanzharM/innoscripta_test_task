import 'package:get_it/get_it.dart';
import 'package:innoscripta_test_task/src/data/datasources/board/board_data_source.dart';
import 'package:innoscripta_test_task/src/data/repositories_impl/board/board_repository_impl.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/theme/app_theme.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  sl
    ..registerLazySingleton(() => AppTheme())
    ..registerLazySingleton(() => const AppRouter())

    // Data sources
    ..registerLazySingleton<BoardDataSource>(
      () => BoardDataSourceImpl(),
    )

    // Repositories
    ..registerLazySingleton<BoardRepository>(
      () => BoardRepositoryImpl(sl()),
    );
}
