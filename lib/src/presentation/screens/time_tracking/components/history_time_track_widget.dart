import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

class HistoryTimeTrackWidget extends StatelessWidget {
  const HistoryTimeTrackWidget({
    super.key,
    required this.timeEntry,
  });

  final TimeEntryEntity timeEntry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(AppConstraints.padding),
        child: Text(
          timeEntry.readableFormat,
          style: theme.textTheme.bodyLarge?.apply(color: theme.primaryColor),
        ),
      ),
    );
  }
}
