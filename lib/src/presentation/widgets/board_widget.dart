import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    super.key,
    required this.boardEntity,
  });

  final BoardEntity boardEntity;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
