part of 'task_bloc.dart';

class TaskState {
  final TaskEntity task;
  final BoardEntity? board;
  final bool isLoading;
  final String error;

  const TaskState({
    required this.task,
    this.board,
    this.isLoading = false,
    this.error = '',
  });

  String get uniqueIdentified {
    String boardName = board?.name ?? '';
    if (boardName.isNotEmpty) {
      boardName = '$boardName ';
    }

    return '$boardName - ${task.id}';
  }

  TaskState copyWith({
    TaskEntity? task,
    BoardEntity? board,
    bool? isLoading,
    String? error,
  }) {
    return TaskState(
      task: task ?? this.task,
      board: board ?? this.board,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() => 'TaskState(task: $task, isLoading: $isLoading, error: $error)';
}

class TaskUpdatedState extends TaskState {
  TaskUpdatedState({
    required super.task,
    super.board,
  });
}

class TaskDeletedState extends TaskState {
  TaskDeletedState({
    required super.task,
    super.board,
  });
}
