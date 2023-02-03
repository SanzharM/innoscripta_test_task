class PaginatedModel<T> {
  final List<T> items;
  final int? page;
  final int? total;

  const PaginatedModel({
    this.items = const [],
    this.page,
    this.total,
  });

  PaginatedModel<T> copyWith({
    List<T>? items,
    int? page,
    int? total,
  }) {
    return PaginatedModel<T>(
      items: items ?? this.items,
      page: page ?? this.page,
      total: total ?? this.total,
    );
  }
}
