import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';

class AppCell extends StatelessWidget {
  const AppCell({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.leading,
    this.isLoading = false,
    this.boxDecoration,
    this.onPressed,
  });

  final String? title;
  final String? subtitle;
  final Widget? child;
  final Widget? leading;
  final bool isLoading;
  final BoxDecoration? boxDecoration;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        decoration: boxDecoration,
        padding: EdgeInsets.all(AppConstraints.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (leading != null) ...[
              AnimatedSwitcher(
                duration: Utils.animationDuration,
                child: isLoading
                    ? SizedBox(
                        height: theme.iconTheme.size ?? 24.0,
                        width: theme.iconTheme.size ?? 24.0,
                        child: CupertinoActivityIndicator(
                          color: theme.iconTheme.color,
                        ),
                      )
                    : leading!,
              ),
              SizedBox(width: AppConstraints.padding),
            ],
            Expanded(
              child: child ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (title?.isNotEmpty ?? false) ...[
                        Text(
                          title!,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyLarge?.apply(
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                      if (subtitle?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 8.0),
                        Text(
                          subtitle!,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.displayLarge?.apply(
                            color: theme.hintColor,
                          ),
                        )
                      ],
                    ],
                  ),
            ),
            if (onPressed != null) ...[
              const Icon(CupertinoIcons.forward),
            ],
          ],
        ),
      ),
    );
  }
}
