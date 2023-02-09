import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/l10n/generated/l10n.dart';
import 'package:innoscripta_test_task/src/core/storage/local_storage.dart';
import 'package:innoscripta_test_task/src/domain/entities/custom_theme/custom_theme.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  void initial() => add(SettingsInitialEvent());
  void update({Locale? locale, ThemeMode? themeMode, CustomTheme? theme}) =>
      add(SettingsUpdateEvent(locale: locale, themeMode: themeMode, theme: theme));

  SettingsBloc() : super(const SettingsState(currentLocale: Locale('en'))) {
    on<SettingsInitialEvent>(_initial);
    on<SettingsUpdateEvent>(_update);
  }

  final _storage = sl<LocalStorage>();

  void _initial(SettingsInitialEvent event, Emitter<SettingsState> emit) async {
    Locale? locale;
    final storedLanguageCode = await _storage.getLanguage();
    if (storedLanguageCode?.isNotEmpty ?? false) {
      locale = Locale(storedLanguageCode!);
      if (!S.delegate.isSupported(locale)) {
        locale = _getSystemLocale();
      }
    } else {
      locale = _getSystemLocale();
    }

    CustomTheme theme = await _storage.getTheme();

    return emit(state.copyWith(currentLocale: locale, theme: theme));
  }

  void _update(SettingsUpdateEvent event, Emitter<SettingsState> emit) async {
    if (event.locale != null) {
      await _storage.setLanguage(event.locale!);
    }
    if (event.theme != null) {
      await _storage.setTheme(event.theme!);
    }
    emit(state.copyWith(themeMode: event.themeMode, currentLocale: event.locale, theme: event.theme));
  }

  Locale _getSystemLocale() {
    final systemLocales = WidgetsBinding.instance.window.locales;
    if (systemLocales.isNotEmpty && S.delegate.isSupported(systemLocales.first)) {
      return systemLocales.first;
    }
    return const Locale('en');
  }
}
