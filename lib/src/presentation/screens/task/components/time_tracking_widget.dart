import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/task/task_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/seconds_builder.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class TimeTrackingWidget extends StatefulWidget {
  const TimeTrackingWidget({super.key});

  @override
  State<TimeTrackingWidget> createState() => _TimeTrackingWidgetState();
}

class _TimeTrackingWidgetState extends State<TimeTrackingWidget> {
  static const int _maxLength = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final task = state.task;
        bool isTicking = task.timeEntries.isNotEmpty && task.timeEntries.last.isActive;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              L10n.of(context).timeTracking,
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: AppConstraints.padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: AppIconButton(
                    child: AnimatedSwitcher(
                      duration: Utils.animationDuration,
                      child: state.isLoading
                          ? CupertinoActivityIndicator(
                              color: theme.iconTheme.color,
                            )
                          : isTicking
                              ? Icon(CupertinoIcons.pause_circle_fill, size: 48.w)
                              : Icon(CupertinoIcons.play_circle_fill, size: 48.w),
                    ),
                    onPressed: () {
                      if (isTicking) {
                        return context.read<TaskBloc>().finishTimeEntry();
                      }
                      return context.read<TaskBloc>().startTimeEntry();
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedSwitcher(
                    duration: Utils.animationDuration,
                    child: isTicking
                        ? SecondsBuilder(
                            timeEntry: task.timeEntries.last,
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstraints.padding),
            ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: AppConstraints.padding,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: task.timeEntries.length > _maxLength ? _maxLength : task.timeEntries.length,
              itemBuilder: (_, i) {
                if (i + 1 == _maxLength) {
                  return AppIconButton(
                    child: Text(
                      L10n.of(context).more,
                    ),
                    onPressed: () {
                      return showAllTimeEntries(task.timeEntries.reversed);
                    },
                  );
                }
                final entry = task.timeEntries.reversed.elementAt(i);
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  onPressed: entry.isActive
                      ? null
                      : () {
                          context.router.toTimeEntryScreen(entry).then((value) {
                            context.read<TaskBloc>().get(task);
                          });
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${Utils.toDayPrefix(context, entry.endTime ?? entry.startTime)}:   ',
                                style: theme.textTheme.bodySmall?.apply(
                                  color: theme.hintColor,
                                ),
                              ),
                              TextSpan(
                                text: entry.readableFormat,
                                style: theme.textTheme.bodyMedium?.apply(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!entry.isActive) const Icon(CupertinoIcons.forward),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showAllTimeEntries(Iterable<TimeEntryEntity> timeEntries) async {
    final theme = Theme.of(context);
    return CustomBottomSheet.show<void>(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(AppConstraints.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetAppBar(
              title: L10n.of(context).timeEntries,
            ),
            ListView.separated(
              padding: EdgeInsets.all(AppConstraints.padding),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: timeEntries.length,
              separatorBuilder: (_, __) => const Divider(
                height: 20.0,
              ),
              itemBuilder: (_, i) {
                final timeEntry = timeEntries.elementAt(i);
                return CupertinoButton(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.zero,
                  onPressed: timeEntry.isActive
                      ? null
                      : () {
                          context.router.back();
                          context.router.toTimeEntryScreen(timeEntry).then((value) {
                            final task = context.read<TaskBloc>().state.task;
                            context.read<TaskBloc>().get(task);
                          });
                        },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              timeEntry.readableFormat,
                            ),
                            if (timeEntry.description?.isNotEmpty ?? false) ...[
                              const SizedBox(height: 4.0),
                              Text(
                                timeEntry.description!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.apply(color: theme.hintColor),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (!timeEntry.isActive) ...[
                        SizedBox(width: AppConstraints.padding),
                        const Icon(CupertinoIcons.forward),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
