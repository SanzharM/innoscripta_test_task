import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/empty_list.dart';

class HistoryTimeTracksBuilder extends StatefulWidget {
  const HistoryTimeTracksBuilder({super.key});

  @override
  State<HistoryTimeTracksBuilder> createState() => _HistoryTimeTracksBuilderState();
}

class _HistoryTimeTracksBuilderState extends State<HistoryTimeTracksBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<TimeTrackingHistoryBloc>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: L10n.of(context).history,
      ),
      body: SafeArea(
        child: BlocBuilder<TimeTrackingHistoryBloc, TimeTrackingHistoryState>(
          builder: (context, state) {
            final historyTracks = state.timeEntries;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TimeTrackingHistoryBloc>().fetch();
                await Future.delayed(Utils.animationDuration);
              },
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Utils.animationDuration,
                      child: state.isLoading
                          ? Center(
                              child: CupertinoActivityIndicator(color: theme.primaryColor),
                            )
                          : historyTracks.isEmpty
                              ? const EmptyList()
                              : ListView.separated(
                                  physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
        context.router.toTimeEntryScreen(timeEntry).then((value) {
          context.read<TimeTrackingHistoryBloc>().fetch();
        });
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
