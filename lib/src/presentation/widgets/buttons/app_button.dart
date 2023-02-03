import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
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
  });

  final String? title;
  final void Function()? onPressed;
  final Widget? child;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoButton(
      padding: padding ?? EdgeInsets.all(AppConstraints.padding),
      onPressed: onPressed,
      child: Container(
        width: double.maxFinite,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: AppConstraints.borderRadius,
          color: backgroundColor ?? theme.primaryColor,
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
