import 'package:innoscripta_test_task/src/data/datasources/board/board_data_source.dart';
import 'package:innoscripta_test_task/src/data/models/paginated_model.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  BoardRepositoryImpl(
    this.dataSource,
  );

  final BoardDataSource dataSource;

  @override
  Future<PaginatedModel<BoardEntity>> fetchBoards(int page, {int perPage = 10}) async {
    return dataSource.fetchBoards(page, perPage);
  }

  @override
  Future<bool> addBoard(String name) {
    return dataSource.addBoard(name);
  }

  @override
  Future<BoardEntity> getBoard(int id) {
    return dataSource.getBoard(id);
  }

  @override
  Future<bool> removeBoard(int id) {
    return dataSource.removeBoard(id);
  }

  @override
  Future<bool> updateBoard(BoardEntity boardEntity) {
    return dataSource.updateBoard(boardEntity);
  }
}
