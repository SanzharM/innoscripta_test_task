import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/status/status_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/screens/board/components/add_task_widget.dart';
import 'package:innoscripta_test_task/src/presentation/screens/board/components/board_info_widget.dart';
import 'package:innoscripta_test_task/src/presentation/screens/board/components/task_widget.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<BoardBloc>().fetch();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(state.error);
        }
        if (state is BoardDeletedState) {
          context.read<BoardListBloc>().refresh();
          context.router.popUntil((route) => route.isFirst);
          return AlertController.showMessage(
            L10n.of(context).boardDeleted,
            isSuccess: true,
          );
        }
      },
      builder: (context, state) {
        final board = state.board;
        return Scaffold(
          appBar: CustomAppBar(
            title: board.name,
            actions: [
              AppIconButton(
                child: const Icon(CupertinoIcons.info),
                onPressed: () async {
                  return CustomBottomSheet.show<void>(
                    context: context,
                    isScrollControlled: true,
                    child: BlocProvider.value(
                      value: context.read<BoardBloc>(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.87,
                          minHeight: MediaQuery.of(context).size.height * 0.33,
                        ),
                        child: const BoardInfoWidget(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 8.w,
                width: double.maxFinite,
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: board.statuses.length,
                    separatorBuilder: (_, __) => SizedBox(width: AppConstraints.padding),
                    itemBuilder: (_, i) {
                      final isActive = state.currentColumnIndex == i;
                      return AnimatedContainer(
                        duration: Utils.animationDuration,
                        width: 8.w,
                        height: 8.w,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? Theme.of(context).highlightColor : Theme.of(context).indicatorColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: board.statuses.length,
                  onPageChanged: context.read<BoardBloc>().changeColumnIndex,
                  itemBuilder: (context, index) {
                    final status = board.statuses.elementAt(index);

                    return _ColumnBuilder(status: status);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ColumnBuilder extends StatefulWidget {
  const _ColumnBuilder({
    Key? key,
    required this.status,
  }) : super(key: key);

  final StatusEntity status;

  @override
  State<_ColumnBuilder> createState() => __ColumnBuilderState();
}

class __ColumnBuilderState extends State<_ColumnBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(state.error);
        }
      },
      builder: (context, state) {
        final tasks = state.board.tasks.where((e) => e.statusEntity == widget.status).toList();
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(AppConstraints.padding),
          decoration: const BoxDecoration(
            borderRadius: AppConstraints.borderRadius,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.status.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    SizedBox(width: AppConstraints.padding),
                    AppIconButton(
                      child: const Icon(Icons.more_horiz_rounded),
                      onPressed: () async {
                        return CustomBottomSheet.show<void>(
                          context: context,
                          isScrollControlled: true,
                          child: Padding(
                            padding: EdgeInsets.all(AppConstraints.padding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SheetAppBar(
                                  title: widget.status.name,
                                ),
                                const Divider(),
                                SizedBox(height: 60.h),
                                AppButton(
                                  title: L10n.of(context).delete,
                                  textColor: AppColors.red,
                                  backgroundColor: AppColors.white,
                                  onPressed: () {},
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(height: 2),
                AppIconButton(
                  child: const Icon(CupertinoIcons.add),
                  onPressed: () async {
                    return CustomBottomSheet.show(
                      context: context,
                      isScrollControlled: true,
                      child: BlocProvider.value(
                        value: context.read<BoardBloc>(),
                        child: const FractionallySizedBox(
                          heightFactor: 0.87,
                          child: AddTaskWidget(),
                        ),
                      ),
                    );
                  },
                ),
                ImplicitlyAnimatedReorderableList<TaskEntity>(
                  shrinkWrap: true,
                  reorderDuration: const Duration(milliseconds: 200),
                  liftDuration: const Duration(milliseconds: 300),
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: AppConstraints.padding,
                  ),
                  areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
                  items: tasks,
                  // onReorderStarted: (item, index) => ,
                  onReorderFinished: (TaskEntity task, int from, int to, List<TaskEntity> newItems) {
                    return context.read<BoardBloc>().update(
                          state.board.copyWith(tasks: newItems),
                        );
                  },
                  updateItemBuilder: (context, animation, taskEntity) {
                    return buildReorderable(
                      taskEntity,
                      (taskEntity) => FadeTransition(
                        opacity: animation,
                        child: taskEntity,
                      ),
                    );
                  },
                  itemBuilder: (context, animation, taskEntity, i) {
                    return buildReorderable(
                      taskEntity,
                      (child) => SizeFadeTransition(
                        sizeFraction: 0.7,
                        curve: Curves.easeInOut,
                        animation: animation,
                        child: child,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Reorderable buildReorderable(
    TaskEntity taskEntity,
    Widget Function(Widget child) transition,
  ) {
    return Reorderable(
      key: ValueKey(taskEntity),
      builder: (context, dragAnimation, inDrag) {
        return transition(
          Handle(
            enabled: true,
            vibrate: false,
            delay: Utils.delayDuration,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppConstraints.padding / 4,
              ),
              child: TaskWidget(
                task: taskEntity,
              ),
            ),
          ),
        );
      },
    );
  }
}
