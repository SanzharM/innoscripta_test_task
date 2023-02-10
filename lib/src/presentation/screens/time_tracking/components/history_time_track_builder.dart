import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/empty_list.dart';

class HistoryTimeTracksBuilder extends StatelessWidget {
  const HistoryTimeTracksBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TimeTrackingHistoryBloc, TimeTrackingHistoryState>(
      builder: (context, state) {
        final historyTracks = state.timeEntries;
        return RefreshIndicator(
          onRefresh: () async {
            context.read<TimeTrackingHistoryBloc>().fetch();
            await Future.delayed(Utils.animationDuration);
          },
          child: AnimatedSwitcher(
            duration: Utils.animationDuration,
            child: state.isLoading
                ? Center(
                    child: CupertinoActivityIndicator(color: theme.primaryColor),
                  )
                : historyTracks.isEmpty
                    ? const EmptyList()
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(AppConstraints.padding),
                        itemCount: historyTracks.length,
                        separatorBuilder: (_, __) => SizedBox(height: AppConstraints.padding),
                        itemBuilder: (_, i) {
                          final timeEntry = historyTracks.elementAt(i);
                          return _HistoryTimeTrackWidget(
                            timeEntry: timeEntry,
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}

class _HistoryTimeTrackWidget extends StatelessWidget {
  const _HistoryTimeTrackWidget({
    Key? key,
    required this.timeEntry,
  }) : super(key: key);

  final TimeEntryEntity timeEntry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        context.router.toTimeEntryScreen(timeEntry);
      },
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
