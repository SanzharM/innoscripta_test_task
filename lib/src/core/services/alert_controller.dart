import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';

class AlertController {
  static void showMessage(String message, {bool isSuccess = false}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: AppStyles.titleSmall.fontSize,
      gravity: ToastGravity.TOP,
      backgroundColor: isSuccess ? AppColors.greenLight : AppColors.greyDark,
      textColor: isSuccess ? AppColors.greyDark : AppColors.white,
    );
    return;
  }

  static void showDecisionDialog({
    required BuildContext context,
    required void Function() onYes,
    void Function()? onNo,
    void Function()? onDismissed,
    bool barrierDismissable = true,
    String? title,
    required String content,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) async {
    final theme = Theme.of(context);

    if (!Platform.isIOS || Platform.isMacOS) {
      await showCupertinoDialog<void>(
        context: context,
        barrierDismissible: barrierDismissable,
        builder: (_) => CupertinoAlertDialog(
          title: title?.isEmpty ?? true
              ? null
              : Text(
                  title!,
                  style: titleStyle ??
                      theme.textTheme.titleMedium?.apply(
                        color: theme.colorScheme.primary,
                      ),
                ),
          content: Text(
            content,
            style: contentStyle ?? theme.textTheme.bodyMedium,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: onNo ?? () => context.router.back(),
              child: Text(
                L10n.of(context).no,
              ),
            ),
            CupertinoDialogAction(
              onPressed: onYes,
              child: Text(
                L10n.of(context).yes,
              ),
            ),
          ],
        ),
      );
      if (onDismissed != null) onDismissed();
      return;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (_) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: title?.isEmpty ?? true
            ? null
            : Text(
                title!,
                style: titleStyle ?? theme.textTheme.titleMedium,
              ),
        content: Text(
          content,
          style: contentStyle ?? theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: onNo ?? () => context.router.back(),
            child: Text(
              L10n.of(context).no,
            ),
          ),
          TextButton(
            onPressed: onYes,
            child: Text(
              L10n.of(context).yes,
            ),
          ),
        ],
      ),
    );
    if (onDismissed != null) onDismissed();
    return;
  }
}
