import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.title,
    this.child,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.alignment = Alignment.center,
  });

  final String? title;
  final void Function()? onPressed;
  final Widget? child;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDisabled = onPressed == null;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      borderRadius: BorderRadius.zero,
      alignment: alignment,
      child: Container(
        padding: padding,
        width: double.maxFinite,
        height: 50.h,
        alignment: alignment,
        decoration: BoxDecoration(
          borderRadius: AppConstraints.borderRadius,
          color: backgroundColor?.withOpacity(
                isDisabled ? 0.33 : 1,
              ) ??
              theme.primaryColor.withOpacity(
                isDisabled ? 0.33 : 1,
              ),
        ),
        child: AnimatedSwitcher(
          duration: Utils.animationDuration,
          child: isLoading
              ? const CupertinoActivityIndicator()
              : child ??
                  Text(
                    title ?? '',
                    style: theme.textTheme.titleSmall?.apply(
                      color: textColor ?? theme.scaffoldBackgroundColor,
                    ),
                  ),
        ),
      ),
    );
  }
}
