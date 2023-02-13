import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/screens/home/components/board_list_builder.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() => Utils.loadMoreListener(
          controller: _scrollController,
          onLoading: () => context.read<BoardListBloc>().fetch(),
        ));
    super.initState();
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
      body: NestedScrollView(
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
          children: const [
            Expanded(
              child: BoardListBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
