part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsInitialEvent extends SettingsEvent {}

class SettingsUpdateEvent extends SettingsEvent {
  final Locale? locale;
  final ThemeMode? themeMode;
  final CustomTheme? theme;

  SettingsUpdateEvent({this.locale, this.themeMode, this.theme});
}
