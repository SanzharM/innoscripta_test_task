import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';

class BoardListBuilder extends StatefulWidget {
  const BoardListBuilder({super.key});

  @override
  State<BoardListBuilder> createState() => _BoardListBuilderState();
}

class _BoardListBuilderState extends State<BoardListBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardListBloc, BoardListState>(
      builder: (context, state) {
        final boards = state.boards;
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(AppConstraints.padding),
          primary: false,
          itemCount: boards.length + 1,
          itemBuilder: (context, index) {
            bool isLast = index + 1 == boards.length + 1;
            if (isLast) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: state.isLoading ? const CupertinoActivityIndicator() : const SizedBox(),
              );
            }
            final board = boards.elementAt(index);
            return _BoardCell(boardEntity: board);
          },
        );
      },
    );
  }
}

class _BoardCell extends StatelessWidget {
  const _BoardCell({
    Key? key,
    required this.boardEntity,
  }) : super(key: key);

  final BoardEntity boardEntity;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(CupertinoIcons.folder_solid),
          SizedBox(width: AppConstraints.padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  boardEntity.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  Utils.formatDate(boardEntity.createdAt) ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: () {
        context.router.toBoardScreen(boardEntity);
      },
    );
  }
}
