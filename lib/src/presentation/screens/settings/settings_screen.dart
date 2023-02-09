import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';

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
              title: Text(
                L10n.of(context).settings,
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
