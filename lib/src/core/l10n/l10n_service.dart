import 'package:flutter/widgets.dart';
import 'package:innoscripta_test_task/src/core/l10n/generated/l10n.dart';

class L10n {
  const L10n();
  static S get current => S.current;
  static S of(BuildContext context) => S.of(context);
}
