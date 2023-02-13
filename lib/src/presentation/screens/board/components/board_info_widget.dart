import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/extensions/extensions.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/report/report_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/cell/app_cell.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class BoardInfoWidget extends StatelessWidget {
  const BoardInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        final board = state.board;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppConstraints.padding),
              child: SheetAppBar(
                title: L10n.of(context).info,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppConstraints.padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: theme.hintColor,
                            borderRadius: AppConstraints.borderRadius,
                            border: Border.all(color: theme.highlightColor)),
                        child: const Icon(CupertinoIcons.folder_solid),
                      ),
                      SizedBox(width: AppConstraints.padding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              board.name,
                              style: theme.textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${L10n.of(context).tasks}: ${board.tasks.length}'
                              ' • '
                              '${L10n.of(context).totalHours(board.tasks.totalSpentHours)}',
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstraints.padding),
                  BlocBuilder<ReportBloc, ReportState>(
                    builder: (context, state) {
                      bool isLoading = state is ReportLoadingState;
                      return AppCell(
                        padding: EdgeInsets.symmetric(
                          vertical: AppConstraints.padding,
                        ),
                        isLoading: isLoading,
                        leading: const Icon(CupertinoIcons.share),
                        title: L10n.of(context).exportBoard,
                        subtitle: L10n.of(context).generateCsv,
                        onPressed: () {
                          if (isLoading) return;
                          context.read<ReportBloc>().generateBoardReport(
                                board.id,
                              );
                        },
                      );
                    },
                  ),
                  AppCell(
                    padding: EdgeInsets.symmetric(
                      vertical: AppConstraints.padding,
                    ),
                    isLoading: state.isLoading,
                    leading: const Icon(CupertinoIcons.delete),
                    title: L10n.of(context).delete,
                    // subtitle: L10n.of(context).board,
                    onPressed: () {
                      if (state.isLoading) return;

                      return AlertController.showDecisionDialog(
                        context: context,
                        content: L10n.of(context).sureDelete,
                        onYes: () {
                          context.read<BoardBloc>().delete(board.id);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
