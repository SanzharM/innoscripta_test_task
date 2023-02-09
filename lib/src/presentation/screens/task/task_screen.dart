import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/task/task_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/screens/task/components/time_tracking_widget.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/app_text_field.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/date_picker_widget.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().get(
          context.read<TaskBloc>().state.task,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(state.error);
        }
      },
      builder: (context, state) {
        final task = state.task;
        return GestureDetector(
          onTap: FocusScope.of(context).hasFocus ? () => FocusScope.of(context).unfocus() : null,
          child: Scaffold(
            appBar: CustomAppBar(
              actions: <Widget>[
                AppIconButton(
                  child: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            body: AnimatedSwitcher(
              duration: Utils.animationDuration,
              child: state.isLoading
                  ? Center(
                      child: CupertinoActivityIndicator(
                        color: theme.highlightColor,
                        radius: 20.w,
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(AppConstraints.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _UniqueIdentifier(),
                          const _TaskName(),
                          const _CurrentStatus(),
                          SizedBox(height: AppConstraints.padding),
                          _Element(
                            title: L10n.of(context).deadline,
                            value: Utils.formatDate(task.deadline) ?? '-',
                            leading: Icon(
                              CupertinoIcons.clock_solid,
                              color: task.isDeadlinePassed ? theme.colorScheme.onError : null,
                            ),
                            onPressed: () async {
                              final picker = DatePickerWidget(
                                context: context,
                                initialDate: task.deadline,
                                minDate: DateTime.now(),
                              );
                              picker.show().then((date) {
                                context.read<TaskBloc>().update(task.copyWith(deadline: date));
                              });
                            },
                          ),
                          const Divider(),
                          SizedBox(height: AppConstraints.padding),
                          const TimeTrackingWidget(),
                          SizedBox(height: AppConstraints.padding),
                          const Divider(),
                          _Element(
                            title: L10n.of(context).description,
                            value: task.description ?? '',
                            onPressed: () {
                              context.router.toTaskDescriptionScreen(
                                BlocProvider.of<TaskBloc>(context),
                              );
                            },
                          ),
                          const Divider(),
                          _Element(
                            title: L10n.of(context).createdAt,
                            value: Utils.formatDate(task.createdAt, format: 'dd.MM.yyyy HH:mm') ?? '-',
                            leading: const Icon(CupertinoIcons.clock_solid),
                            onPressed: null,
                          ),
                          _Element(
                            title: L10n.of(context).lastUpdateDate,
                            value: Utils.formatDate(task.updatedAt, format: 'dd.MM.yyyy HH:mm') ?? '-',
                            leading: const Icon(CupertinoIcons.clock_solid),
                            onPressed: null,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _UniqueIdentifier extends StatelessWidget {
  const _UniqueIdentifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.event_note_rounded,
          color: theme.highlightColor,
        ),
        SizedBox(width: 10.w),
        Flexible(
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return Text(
                state.uniqueIdentified,
                style: theme.textTheme.bodySmall?.apply(
                  color: theme.hintColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TaskName extends StatelessWidget {
  const _TaskName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController(
      text: context.read<TaskBloc>().state.task.name,
    );
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final task = state.task;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppConstraints.padding),
          child: AppTextField(
            controller: controller,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.done,
            withBorder: false,
            textStyle: theme.textTheme.titleLarge?.copyWith(
              fontSize: 32,
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              if (controller.text.isEmpty) return;
              context.read<TaskBloc>().update(
                    task.copyWith(name: controller.text),
                  );
            },
            onFieldSubmitted: (value) {
              if (controller.text.isEmpty) return;
              context.read<TaskBloc>().update(
                    task.copyWith(name: controller.text),
                  );
            },
          ),
        );
      },
    );
  }
}

class _CurrentStatus extends StatelessWidget {
  const _CurrentStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final task = state.task;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppConstraints.padding / 2,
                  horizontal: AppConstraints.padding,
                ),
                decoration: BoxDecoration(
                  color: theme.highlightColor,
                  borderRadius: AppConstraints.borderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  task.statusEntity.name,
                  style: theme.textTheme.bodyLarge?.apply(
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
              onPressed: () {
                return showStatuses(
                  context: context,
                  task: task,
                  statuses: state.board?.statuses ?? [],
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showStatuses({
    required BuildContext context,
    required TaskEntity task,
    List<StatusEntity> statuses = const [],
  }) async {
    var availableStatuses = List<StatusEntity>.from(statuses);
    if (availableStatuses.isEmpty) {
      availableStatuses = StatusEntity.defaultValues;
    }
    availableStatuses.remove(task.statusEntity);

    return CustomBottomSheet.show(
      context: context,
      isScrollControlled: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(AppConstraints.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetAppBar(
              title: L10n.of(context).changeTaskStatus,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: AppConstraints.padding,
              ),
              itemCount: availableStatuses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8.0),
              itemBuilder: (_, i) {
                final status = availableStatuses.elementAt(i);
                return AppButton(
                  title: status.name,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  textColor: Theme.of(context).highlightColor,
                  onPressed: () {
                    context.read<TaskBloc>().update(task.copyWith(statusEntity: status));
                    context.router.back();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _Element extends StatelessWidget {
  const _Element({
    Key? key,
    required this.title,
    required this.value,
    // ignore: unused_element
    this.leading,
    // ignore: unused_element
    this.padding,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String value;
  final Widget? leading;
  final EdgeInsets? padding;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoButton(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: AppConstraints.padding,
          ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: AppConstraints.padding),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.apply(
                    color: theme.hintColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          if (onPressed != null) ...[
            AppIconButton(
              onPressed: onPressed,
              child: const Icon(CupertinoIcons.forward),
            ),
          ],
        ],
      ),
    );
  }
}
