import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking/time_tracking_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/screens/time_tracking/components/history_time_track_widget.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';

class TimeTrackingScreen extends StatefulWidget {
  const TimeTrackingScreen({super.key});

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<TimeTrackingBloc, TimeTrackingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  title: Text(
                    L10n.of(context).timeTracking,
                  ),
                ),
              ];
            },
            body: BlocBuilder<TimeTrackingHistoryBloc, TimeTrackingHistoryState>(
              builder: (context, state) {
                final historyTracks = state.timeEntries;
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<TimeTrackingHistoryBloc>().fetch();
                    await Future.delayed(Utils.delayDuration);
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(AppConstraints.padding),
                    itemCount: historyTracks.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: AppConstraints.padding / 2,
                    ),
                    itemBuilder: (_, i) {
                      final timeEntry = historyTracks.elementAt(i);
                      return HistoryTimeTrackWidget(
                        timeEntry: timeEntry,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          floatingActionButton: BlocBuilder<TimeTrackingBloc, TimeTrackingState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: 48.h),
                child: AppIconButton(
                  padding: EdgeInsets.zero,
                  child: AnimatedSwitcher(
                    duration: Utils.animationDuration,
                    child: state.isLoading
                        ? CupertinoActivityIndicator(color: theme.highlightColor)
                        : state.isFinished
                            ? Icon(
                                CupertinoIcons.play_circle_fill,
                                color: theme.highlightColor,
                                size: 64.w,
                              )
                            : Icon(
                                CupertinoIcons.pause_circle_fill,
                                color: theme.highlightColor,
                                size: 64.w,
                              ),
                  ),
                  onPressed: () {
                    context.read<TimeTrackingBloc>().startTimer();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
