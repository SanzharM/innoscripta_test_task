class PaginationException implements Exception {
  final String? message;

  const PaginationException({this.message});
}

class TaskNotFoundException implements Exception {
  final String? message;

  const TaskNotFoundException({this.message});
}
