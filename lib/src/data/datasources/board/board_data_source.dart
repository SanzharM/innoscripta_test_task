import 'package:hive_flutter/adapters.dart';
import 'package:innoscripta_test_task/src/core/extensions/extensions.dart';
import 'package:innoscripta_test_task/src/core/storage/hive_storage.dart';
import 'package:innoscripta_test_task/src/data/models/paginated_model.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';

abstract class BoardDataSource {
  Future<PaginatedModel<BoardEntity>> fetchBoards(int page, int perPage);

  Future<bool> addBoard(String name);

  Future<BoardEntity> getBoard(int id);

  Future<bool> removeBoard(int id);

  Future<bool> updateBoard(BoardEntity boardEntity);
}

class BoardDataSourceImpl implements BoardDataSource {
  Box<BoardEntity> get box => Hive.box<BoardEntity>(HiveStorage.boardBox);

  int _getLastId() {
    if (box.values.isEmpty) {
      return 0;
    }
    return box.values.last.id;
  }

  @override
  Future<PaginatedModel<BoardEntity>> fetchBoards(int page, int perPage) async {
    var items = List<BoardEntity>.from(box.values).reversed.toList();

    return PaginatedModel<BoardEntity>(
      page: page,
      items: items.pagination(page, perPage: perPage),
      total: items.length,
    );
  }

  @override
  Future<bool> addBoard(String name) async {
    final value = BoardEntity(
      id: _getLastId() + 1,
      name: name,
      createdAt: DateTime.now(),
    );

    box.add(value);
    return true;
  }

  @override
  Future<BoardEntity> getBoard(int id) async {
    for (var item in box.values) {
      if (item.id == id) {
        return item;
      }
    }
    throw Exception('Board($id) not found');
  }

  @override
  Future<bool> removeBoard(int id) async {
    for (int i = 0; i < box.values.length; i++) {
      if (box.values.elementAt(i).id == id) {
        box.deleteAt(i);
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> updateBoard(BoardEntity boardEntity) async {
    var items = List<BoardEntity>.from(box.values);

    int index = items.indexOf(boardEntity);
    if (index <= -1) {
      return false;
    }

    box.deleteAt(index);
    box.add(boardEntity.copyWith(updatedAt: DateTime.now()));
    return true;
  }
}
