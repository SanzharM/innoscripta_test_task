import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/core/storage/hive_storage.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking_history/time_tracking_history_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              title: Text(
                L10n.of(context).settings,
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.symmetric(
            vertical: AppConstraints.padding,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            _SettingsElement(
              leading: const Icon(CupertinoIcons.globe),
              title: L10n.of(context).language,
              onPressed: () {
                context.router.toLanguagesScreen();
              },
            ),
            _SettingsElement(
              leading: const Icon(CupertinoIcons.paintbrush_fill),
              title: L10n.of(context).themes,
              onPressed: () {
                context.router.toThemesScreen();
              },
            ),
            _SettingsElement(
              leading: const Icon(CupertinoIcons.paintbrush_fill),
              title: L10n.of(context).clearLocalStorage,
              onPressed: () {
                return AlertController.showDecisionDialog(
                  context: context,
                  content: L10n.of(context).allLocalDataWillBeDeleted,
                  onYes: () async {
                    // await sl<LocalStorage>().clearStorage();
                    sl<HiveStorage>().reset().then((value) {
                      context.read<BoardListBloc>()
                        ..reset()
                        ..fetch();
                      context.read<TimeTrackingHistoryBloc>()
                        ..reset()
                        ..fetch();
                      context.router.back();
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsElement extends StatelessWidget {
  const _SettingsElement({
    Key? key,
    required this.leading,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final Widget leading;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(AppConstraints.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading,
          SizedBox(width: AppConstraints.padding),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          SizedBox(width: AppConstraints.padding),
          const Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}
