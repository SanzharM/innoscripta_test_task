import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/extensions/extensions.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_entry/time_entry_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/app_text_field.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/date_picker_widget.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class TimeEntryScreen extends StatefulWidget {
  const TimeEntryScreen({super.key});

  @override
  State<TimeEntryScreen> createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    context.read<TimeEntryBloc>().get();
    _textController = TextEditingController(
      text: context.read<TimeEntryBloc>().state.timeEntry.description,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimeEntryBloc, TimeEntryState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(state.error);
        }

        if (state is TimeEntryUpdatedState) {
          return AlertController.showMessage(
            L10n.of(context).timeEntryUpdated,
            isSuccess: true,
          );
        }

        if (state is TimeEntryDeletedState) {
          context.router.back();
          context.read<TimeTrackingHistoryBloc>().fetch();
          return AlertController.showMessage(
            L10n.of(context).timeEntryDeleted,
            isSuccess: true,
          );
        }
      },
      builder: (context, state) {
        final timeEntry = state.timeEntry;
        return GestureDetector(
          onTap: FocusScope.of(context).hasFocus ? () => FocusScope.of(context).unfocus() : null,
          child: Scaffold(
            appBar: CustomAppBar(
              actions: [
                AppIconButton(
                  onPressed: showOptions,
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _RelatedTaskWidget(),
                  _TimeWidget(
                    label: L10n.of(context).startTime,
                    time: timeEntry.startTime,
                    onDateChanged: null,
                  ),
                  _TimeWidget(
                    label: L10n.of(context).endTime,
                    time: timeEntry.endTime,
                    onDateChanged: (value) {
                      if (value?.isBefore(timeEntry.startTime) ?? true) {
                        return;
                      }
                      context.read<TimeEntryBloc>().update(
                            timeEntry.copyWith(endTime: value),
                          );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppConstraints.padding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          L10n.of(context).description,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodySmall?.apply(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        AppTextField(
                          controller: _textController,
                          textInputAction: TextInputAction.newline,
                          onTapOutside: (event) {
                            if (_textController.text == timeEntry.description) {
                              return;
                            }
                            context.read<TimeEntryBloc>().update(
                                  timeEntry.copyWith(description: _textController.text),
                                );
                          },
                          onEditingComplete: () {
                            if (_textController.text == timeEntry.description) {
                              return;
                            }
                            context.read<TimeEntryBloc>().update(
                                  timeEntry.copyWith(description: _textController.text),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppConstraints.padding),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showOptions() async {
    return CustomBottomSheet.show<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      child: Padding(
        padding: EdgeInsets.all(AppConstraints.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetAppBar(title: L10n.of(context).options),
            SizedBox(height: AppConstraints.padding),
            AppButton(
              title: L10n.of(context).connectToAnotherTask,
              onPressed: () {
                context.router.back();
              },
            ),
            SizedBox(height: AppConstraints.padding),
            AppButton(
              title: L10n.of(context).delete,
              onPressed: () {
                return AlertController.showDecisionDialog(
                  context: context,
                  content: L10n.of(context).sureDelete,
                  onYes: () {
                    final timeEntry = context.read<TimeEntryBloc>().state.timeEntry;
                    context.read<TimeEntryBloc>().delete(timeEntry);
                    context.router.back(); // Alert dialog
                    context.router.back(); // Bottom sheet
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RelatedTaskWidget extends StatelessWidget {
  const _RelatedTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TimeEntryBloc, TimeEntryState>(
      builder: (context, state) {
        final task = state.taskEntity;
        return AnimatedSwitcher(
          duration: Utils.delayDuration,
          child: task == null
              ? const SizedBox()
              : Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(AppConstraints.padding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.of(context).task,
                        overflow: TextOverflow.fade,
                        style: theme.textTheme.bodySmall?.apply(
                          color: theme.hintColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        task.name,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _TimeWidget extends StatelessWidget {
  const _TimeWidget({
    Key? key,
    required this.label,
    required this.time,
    required this.onDateChanged,
  }) : super(key: key);

  final String label;
  final DateTime? time;
  final void Function(DateTime? value)? onDateChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDisabled = onDateChanged == null;

    String prefix = '';
    String format = 'dd.MM.yyyy | HH:mm:ss';
    if (time?.isToday ?? false) {
      format = '| HH:mm:ss';
      prefix = L10n.of(context).today;
    } else if (time?.isYesterday ?? false) {
      format = '| HH:mm:ss';
      prefix = L10n.of(context).yesterday;
    }

    return CupertinoButton(
      padding: EdgeInsets.all(AppConstraints.padding),
      alignment: Alignment.centerLeft,
      onPressed: isDisabled
          ? null
          : () async {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
              DateTime? value;
              value = await DatePickerWidget(
                context: context,
                initialDate: time,
                pickerMode: PickerMode.datetime,
              ).show();
              return onDateChanged!(value);
            },
      child: Row(
        children: [
          if (isDisabled)
            const Icon(
              CupertinoIcons.clock,
            )
          else
            const Icon(
              CupertinoIcons.clock_fill,
            ),
          SizedBox(width: AppConstraints.padding),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: theme.textTheme.bodySmall?.apply(
                    color: theme.hintColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '$prefix ${Utils.formatDate(time, format: format) ?? '-'}',
                  style: theme.textTheme.bodyLarge?.apply(
                    color: isDisabled ? theme.hintColor : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
