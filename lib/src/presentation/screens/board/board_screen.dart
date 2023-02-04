import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late BoardBloc _bloc;
  // = BoardBloc(BoardEntity(id: 0, name: ' asdas', createdAt: DateTime.now()));

  @override
  void initState() {
    _bloc = BoardBloc(BoardEntity(id: 0, name: ' asdas', createdAt: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(state.error);
        }
      },
      builder: (context, state) {
        final board = state.board;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              board.name,
            ),
          ),
        );
      },
    );
  }
}
