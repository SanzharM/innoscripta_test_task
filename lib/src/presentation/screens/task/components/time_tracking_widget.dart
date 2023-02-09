import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/task/task_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';

class TimeTrackingWidget extends StatefulWidget {
  const TimeTrackingWidget({super.key});

  @override
  State<TimeTrackingWidget> createState() => _TimeTrackingWidgetState();
}

class _TimeTrackingWidgetState extends State<TimeTrackingWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final task = state.task;
        bool isTicking = task.timeEntries.isNotEmpty && task.timeEntries.last.isActive;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.of(context).timeTracking,
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: AppConstraints.padding),
                      AppIconButton(
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
                          var entries = List<TimeEntryEntity>.from(task.timeEntries);
                          if (isTicking) {
                            var activeEntry = entries.last;
                            entries.removeAt(entries.length - 1);
                            entries.add(activeEntry.finish());
                          } else {
                            entries.add(TimeEntryEntity(startTime: DateTime.now()));
                          }
                          return context.read<TaskBloc>().update(
                                task.copyWith(timeEntries: entries),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AnimatedSwitcher(
                    duration: Utils.animationDuration,
                    child: isTicking
                        ? _SecondsBuilder(
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
              itemCount: task.timeEntries.length,
              itemBuilder: (_, i) {
                final entry = task.timeEntries.elementAt(i);
                return RichText(
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
                        text: '${Utils.formatDate(entry.startTime, format: 'HH:mm:ss')}'
                            ' - '
                            '${Utils.formatDate(entry.endTime, format: 'HH:mm:ss') ?? ' ...'}',
                        style: theme.textTheme.bodyMedium?.apply(),
                      ),
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
}

class _SecondsBuilder extends StatefulWidget {
  const _SecondsBuilder({
    Key? key,
    required this.timeEntry,
  }) : super(key: key);

  final TimeEntryEntity timeEntry;

  @override
  State<_SecondsBuilder> createState() => __SecondsBuilderState();
}

class __SecondsBuilderState extends State<_SecondsBuilder> {
  final Stream<int> _secondsStream = Stream<int>.periodic(
    const Duration(seconds: 1),
    (int count) => count,
  );

  late StreamSubscription _subcription;

  late int _seconds;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    int initialDifference = now.difference(widget.timeEntry.startTime).inSeconds;
    _seconds = initialDifference;

    _subcription = _secondsStream.listen((event) {
      setState(() => _seconds = initialDifference + event);
    });
  }

  @override
  void dispose() {
    _subcription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        Utils.toTimerFormat(_seconds),
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 26,
            ),
      ),
    );
  }
}
