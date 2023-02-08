import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:innoscripta_test_task/src/core/storage/hive_storage.dart';
import 'package:innoscripta_test_task/src/core/storage/local_storage.dart';
import 'package:innoscripta_test_task/src/data/datasources/board/board_data_source.dart';
import 'package:innoscripta_test_task/src/data/datasources/task/task_data_source.dart';
import 'package:innoscripta_test_task/src/data/repositories_impl/board/board_repository_impl.dart';
import 'package:innoscripta_test_task/src/data/repositories_impl/task/task_repository_impl.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/theme/app_theme.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  sl
    ..registerLazySingleton(() => AppTheme())
    ..registerLazySingleton(() => const FlutterSecureStorage())
    ..registerLazySingleton(() => LocalStorage())
    ..registerLazySingleton(() => HiveStorage())
    ..registerLazySingleton(() => const AppRouter())

    // Data sources
    ..registerLazySingleton<BoardDataSource>(
      () => BoardDataSourceImpl(),
    )
    ..registerLazySingleton<TaskDataSource>(
      () => TaskDataSourceImpl(),
    )

    // Repositories
    ..registerLazySingleton<BoardRepository>(
      () => BoardRepositoryImpl(sl()),
    )
    ..registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(sl()),
    );
}
