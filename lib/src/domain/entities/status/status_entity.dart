class StatusEntity {
  final int id;
  final String name;

  static const todo = StatusEntity(id: 1, name: 'To do');
  static const inProgress = StatusEntity(id: 2, name: 'In progress');
  static const done = StatusEntity(id: 3, name: 'Done');

  static const defaultValues = <StatusEntity>[todo, inProgress, done];

  const StatusEntity({
    required this.id,
    required this.name,
  });

  StatusEntity copyWith({
    int? id,
    String? name,
  }) {
    return StatusEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'StatusEntity(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
