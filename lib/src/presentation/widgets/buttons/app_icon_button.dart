import 'package:flutter/cupertino.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.onPressed,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  final void Function()? onPressed;
  final Widget child;
  final EdgeInsets padding;

  factory AppIconButton.back(BuildContext context) {
    return AppIconButton(
      onPressed: () => context.router.back(),
      child: const Icon(CupertinoIcons.back),
    );
  }

  factory AppIconButton.close(BuildContext context, {void Function()? onPressed}) {
    return AppIconButton(
      onPressed: onPressed ?? () => context.router.back(),
      child: const Icon(CupertinoIcons.xmark_circle_fill),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding,
      onPressed: onPressed,
      child: child,
    );
  }
}
