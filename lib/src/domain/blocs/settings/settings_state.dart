part of 'settings_bloc.dart';

class SettingsState {
  final Locale currentLocale;
  final ThemeMode themeMode;
  final CustomTheme theme;

  const SettingsState({
    required this.currentLocale,
    this.themeMode = ThemeMode.system,
    this.theme = CustomTheme.defaultTheme,
  });

  SettingsState copyWith({
    Locale? currentLocale,
    ThemeMode? themeMode,
    CustomTheme? theme,
  }) {
    return SettingsState(
      currentLocale: currentLocale ?? this.currentLocale,
      themeMode: themeMode ?? this.themeMode,
      theme: theme ?? this.theme,
    );
  }

  @override
  String toString() => 'SettingsState(currentLocale: $currentLocale, themeMode: $themeMode, theme: $theme)';
}
