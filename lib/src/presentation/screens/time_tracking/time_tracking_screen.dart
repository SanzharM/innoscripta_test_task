import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/nav_bar/nav_bar_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/report/report_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking/time_tracking_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/cell/app_cell.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class TimeTrackingScreen extends StatefulWidget {
  const TimeTrackingScreen({super.key});

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Utils.animationDuration);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<TimeTrackingBloc, TimeTrackingState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(state.error);
        }

        if (state is TimerTrackingStartedState) {
          context.read<TimeTrackingHistoryBloc>().fetch();
        }

        if (state is TimerTrackingFinishedState) {
          _controller.forward();
          context.read<TimeTrackingHistoryBloc>().fetch();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                CustomSliverAppBar(
                  title: L10n.of(context).timeTracking,
                ),
              ];
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppConstraints.padding),
                  child: AnimatedSwitcher(
                    duration: Utils.animationDuration,
                    transitionBuilder: (child, animation) => SizeTransition(sizeFactor: animation, child: child),
                    child: state.isActive && state.timeEntry != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                L10n.of(context).currentTimeTracking,
                                style: theme.textTheme.bodyMedium?.apply(
                                  color: theme.hintColor,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                Utils.toTimerFormat(state.currentDuration),
                                style: theme.textTheme.titleMedium,
                              ),
                              SizedBox(height: AppConstraints.padding),
                            ],
                          )
                        : Text(
                            L10n.of(context).pressButtonToStartTracking,
                            style: theme.textTheme.bodyMedium?.apply(
                              color: theme.hintColor,
                            ),
                          ),
                  ),
                ),
                AppCell(
                  leading: const Icon(CupertinoIcons.time),
                  child: AlignTransition(
                    alignment: AlignmentTween(
                      begin: Alignment.centerLeft,
                      end: Alignment.center,
                    ).animate(_controller),
                    child: Text(
                      L10n.of(context).history,
                      style: theme.textTheme.titleLarge?.apply(color: theme.primaryColor),
                    ),
                  ),
                  onPressed: () {
                    context.router.toHistoryTimeTracks().then((value) {
                      context.read<TimeTrackingHistoryBloc>().fetch();
                    });
                  },
                ),
                SizedBox(height: AppConstraints.padding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppConstraints.padding),
                  child: Text(
                    L10n.of(context).reports,
                    style: theme.textTheme.bodyLarge?.apply(color: theme.hintColor),
                  ),
                ),
                BlocConsumer<ReportBloc, ReportState>(
                  listener: (context, state) {
                    if (state is ReportErrorState) {
                      return AlertController.showMessage(state.error);
                    }
                    if (state is ReportCsvGeneratedState) {
                      return AlertController.showMessage(
                        L10n.of(context).report,
                        isSuccess: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is ReportLoadingState;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppCell(
                          leading: const Icon(CupertinoIcons.share),
                          title: L10n.of(context).exportBoard,
                          subtitle: L10n.of(context).generateCsv,
                          isLoading: isLoading,
                          onPressed: () {
                            if (isLoading) return;
                            final boards = context.read<BoardListBloc>().state.boards;
                            return _showBoards(boards);
                          },
                        ),
                        AppCell(
                          leading: const Icon(CupertinoIcons.share),
                          title: L10n.of(context).exportHistoryTimeTracks,
                          subtitle: L10n.of(context).generateCsv,
                          isLoading: isLoading,
                          onPressed: () {
                            if (isLoading) return;

                            var timeEntries = List<TimeEntryEntity>.from(
                              context.read<TimeTrackingHistoryBloc>().state.timeEntries,
                            ).where((element) => !element.isActive).toList();

                            final rows = [
                              TimeEntryEntity.csvColumnNames,
                              ...timeEntries.map((e) => e.toCsv()).toList(),
                            ];
                            context.read<ReportBloc>().generateCsv(rows);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 48.h),
            child: AppIconButton(
              padding: EdgeInsets.zero,
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (state.isActive) {
                        return context.read<TimeTrackingBloc>().finish(state.timeEntry!);
                      }
                      return context.read<TimeTrackingBloc>().startTimer();
                    },
              child: AnimatedSwitcher(
                duration: Utils.animationDuration,
                child: state.isLoading
                    ? CupertinoActivityIndicator(color: theme.highlightColor)
                    : state.isActive
                        ? Icon(
                            CupertinoIcons.pause_circle_fill,
                            color: theme.highlightColor,
                            size: 64.w,
                          )
                        : Icon(
                            CupertinoIcons.play_circle_fill,
                            color: theme.highlightColor,
                            size: 64.w,
                          ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBoards(List<BoardEntity> boards) async {
    return CustomBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(AppConstraints.padding),
            child: SheetAppBar(title: L10n.of(context).boards),
          ),
          if (boards.isEmpty) ...[
            CupertinoButton(
              child: Text(L10n.of(context).add),
              onPressed: () {
                context.read<NavBarBloc>().changeTab(0);
                context.router.back();
                context.router.toAddBoardScreen();
              },
            ),
            SizedBox(height: AppConstraints.padding),
          ] else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: AppConstraints.padding),
              itemCount: boards.length,
              itemBuilder: (_, i) {
                final board = boards.elementAt(i);
                return AppCell(
                  title: board.name,
                  subtitle: Utils.formatDate(board.createdAt),
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).highlightColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      (i + 1).toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  onPressed: () {
                    context.read<ReportBloc>().generateBoardReport(board.id);
                    context.router.back();
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
