import 'package:innoscripta_test_task/src/data/models/paginated_model.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';

abstract class BoardDataSource {
  Future<PaginatedModel<BoardEntity>> fetchBoards(int page, int perPage);
}

class BoardDataSourceImpl implements BoardDataSource {
  @override
  Future<PaginatedModel<BoardEntity>> fetchBoards(int page, int perPage) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return PaginatedModel(
      page: page,
      items: [],
      total: 0,
    );
  }
}
