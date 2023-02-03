import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';

import 'board_list_bloc/board_list_bloc.dart';

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
            return Text(
              board.name,
            );
          },
        );
      },
    );
  }
}
