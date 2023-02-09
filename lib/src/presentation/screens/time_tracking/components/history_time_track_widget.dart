import 'package:flutter/cupertino.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

class HistoryTimeTrackWidget extends StatelessWidget {
  const HistoryTimeTrackWidget({
    super.key,
    required this.timeEntry,
  });

  final TimeEntryEntity timeEntry;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(),
      onPressed: () {},
    );
  }
}
