import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/extensions/extensions.dart';
import 'package:innoscripta_test_task/src/core/l10n/generated/l10n.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/domain/blocs/settings/settings_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late List<Locale> supportedLocales;

  @override
  void initState() {
    supportedLocales = S.delegate.supportedLocales;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: L10n.of(context).languages,
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(AppConstraints.padding),
            itemCount: supportedLocales.length,
            itemBuilder: (_, i) {
              final locale = supportedLocales.elementAt(i);
              final isSelected = locale.languageCode == state.currentLocale.languageCode;
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (isSelected) {
                    return context.router.back();
                  }
                  return context.read<SettingsBloc>().update(locale: locale);
                },
                child: Container(
                  padding: EdgeInsets.all(AppConstraints.padding),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: isSelected ? Border.all(color: theme.highlightColor) : null,
                    borderRadius: AppConstraints.borderRadius,
                  ),
                  child: Text(
                    locale.languageName,
                    style: theme.textTheme.titleMedium?.apply(
                      color: isSelected ? theme.highlightColor : null,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
