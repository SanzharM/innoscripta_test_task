import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';

class CustomBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      elevation: 2.0,
      useSafeArea: true,
      enableDrag: enableDrag,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: AppConstraints.borderRadiusTLR,
      ),
      builder: (_) => child,
    );
  }
}
