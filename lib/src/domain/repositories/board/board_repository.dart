import 'package:innoscripta_test_task/src/data/models/paginated_model.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';

abstract class BoardRepository {
  Future<PaginatedModel<BoardEntity>> fetchBoards(int page, {int perPage = 10});
}
