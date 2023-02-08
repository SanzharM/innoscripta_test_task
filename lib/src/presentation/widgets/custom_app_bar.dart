import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.actions = const [],
    this.title,
    this.titleStyle,
    this.needLeading = true,
  });

  final List<Widget> actions;
  final String? title;
  final TextStyle? titleStyle;
  final bool needLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: needLeading ? AppIconButton.back(context) : null,
      automaticallyImplyLeading: true,
      titleTextStyle: titleStyle,
      title: title == null
          ? null
          : Text(
              title!,
            ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
