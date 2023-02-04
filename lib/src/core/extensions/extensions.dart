import 'package:innoscripta_test_task/src/core/exceptions/exceptions.dart';

extension XPaginationList<T> on List<T> {
  List<T> pagination(int page, {int perPage = 10}) {
    if (page <= 0) {
      throw const PaginationException();
    }

    if ((length / perPage) >= page - 1) {
      int rangeStart = perPage * (page - 1);
      int rangeEnd = perPage * page;
      if (rangeEnd > length) {
        rangeEnd = length;
      }
      return getRange(rangeStart, rangeEnd).toList();
    }
    return [];
  }
}
