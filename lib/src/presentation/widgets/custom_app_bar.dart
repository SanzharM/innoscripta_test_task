import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
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

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      primary: true,
      stretch: true,
      pinned: true,
      elevation: 0,
      floating: true,
      expandedHeight: AppBar().preferredSize.height + AppConstraints.padding,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        centerTitle: false,
        expandedTitleScale: 1.2,
        titlePadding: EdgeInsets.only(
          left: AppConstraints.padding,
          bottom: AppConstraints.padding / 2,
        ),
        title: Text(
          title,
          style: theme.appBarTheme.titleTextStyle,
        ),
        // background: Center(
        //   child: SizedBox(
        //     width: double.maxFinite,
        //     child: Padding(
        //       padding: EdgeInsets.all(AppConstraints.padding),
        //       child: Text(
        //         title,
        //         textAlign: TextAlign.left,
        //         style: theme.appBarTheme.titleTextStyle,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
