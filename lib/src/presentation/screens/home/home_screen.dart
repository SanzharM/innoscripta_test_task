import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/screens/home/components/board_list_builder.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  late BoardListBloc _boardsBloc;

  @override
  void initState() {
    super.initState();
    _boardsBloc = context.read<BoardListBloc>();
    // _scrollController.addListener(
    //   () => Utils.loadMoreListener(
    //     controller: _scrollController,
    //     onLoading: () => context.read<BoardListBloc>().fetch(),
    //   ),
    // );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          _boardsBloc.refresh();
        },
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CustomSliverAppBar(
                title: L10n.of(context).home,
              ),
            ];
          },
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoButton(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: AppConstraints.padding),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.folder_fill_badge_plus),
                    SizedBox(width: AppConstraints.padding),
                    Flexible(
                      child: Text(
                        L10n.of(context).newBoard,
                        style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  context.router.toAddBoardScreen();
                },
              ),
              const Divider(),
              const Expanded(
                child: BoardListBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
