import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/screens/task/components/time_tracking_widget.dart';

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
    final theme = Theme.of(context);
    return BlocBuilder<TimeTrackingHistoryBloc, TimeTrackingHistoryState>(
      builder: (context, state) {
        final timeEntries = state.timeEntries.where((e) => e.taskId == task.id).toList();
        TimeEntryEntity? activeTimeEntry;
        if (timeEntries.any((e) => e.isActive)) {
          activeTimeEntry = timeEntries.firstWhere((e) => e.isActive);
        }
        return CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(AppConstraints.padding),
            decoration: BoxDecoration(
              borderRadius: AppConstraints.borderRadius,
              color: theme.primaryColor.withOpacity(0.1),
              border: activeTimeEntry == null ? null : Border.all(color: theme.highlightColor, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (Utils.formatDate(task.deadline) != null) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.clock,
                        color: theme.colorScheme.error,
                        size: 16.w,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          Utils.formatDate(task.deadline)!,
                          maxLines: 1,
                          style: theme.textTheme.displayLarge?.apply(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstraints.padding / 2),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        task.name,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 3,
                      ),
                    ),
                    if (activeTimeEntry != null) ...[
                      SizedBox(width: 4.w),
                      Flexible(
                        flex: 1,
                        child: SecondsBuilder(
                          timeEntry: activeTimeEntry,
                          textStyle: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ],
                ),
                if (task.description != null) ...[
                  SizedBox(height: AppConstraints.padding / 2),
                  Text(
                    task.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.apply(color: theme.hintColor),
                  ),
                ],
              ],
            ),
          ),
          onPressed: () {
            context.router.toTaskScreen(task).then((value) {
              context.read<BoardBloc>().fetch();
              context.read<TimeTrackingHistoryBloc>().fetch();
            });
          },
        );
      },
    );
  }
}
