import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
    this.statuses = StatusEntity.defaultValues,
  });

  final TaskEntity task;
  final List<StatusEntity> statuses;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(AppConstraints.padding),
        decoration: BoxDecoration(
          borderRadius: AppConstraints.borderRadius,
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        child: Text(
          task.name,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 3,
        ),
      ),
      onPressed: () async {
        context.router.toTaskScreen(task).then(
              (value) => context.read<BoardBloc>().fetch(),
            );
      },
    );
  }
}
