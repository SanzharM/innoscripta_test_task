import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        L10n.of(context).listIsEmpty,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
